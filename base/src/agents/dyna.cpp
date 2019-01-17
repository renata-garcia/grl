/** \file dyna.cpp
 * \brief Dyna agent source file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-01-22
 *
 * \copyright \verbatim
 * Copyright (c) 2015, Wouter Caarls
 * All rights reserved.
 *
 * This file is part of GRL, the Generic Reinforcement Learning library.
 *
 * GRL is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * \endverbatim
 */

#include <unistd.h>
#include <iomanip>

#include <grl/agents/dyna.h>

using namespace grl;

REGISTER_CONFIGURABLE(DynaAgent)

void DynaAgentThread::run()
{
  while (ok())
  {
    while (agent_->total_planned_steps_ < agent_->total_control_steps_*agent_->planning_steps_)
      agent_->runModel();
    usleep(0);
  }
}

void DynaAgent::request(ConfigurationRequest *config)
{
  config->push_back(CRP("planning_steps", "Number of planning steps per control step", planning_steps_, CRP::Online, 0));
  config->push_back(CRP("planning_horizon", "Planning episode length", planning_horizon_, CRP::Configuration, 0));
  config->push_back(CRP("threads", "Threads used for planning (0 = synchronous planning. >0 requires reentrant model_agent)", threads_, CRP::Configuration, 0, INT_MAX));

  config->push_back(CRP("policy", "mapping/policy", "Control policy", policy_));
  config->push_back(CRP("predictor", "predictor", "Value function predictor", predictor_));
  config->push_back(CRP("model", "observation_model", "Observation model used for planning", model_));
  config->push_back(CRP("model_predictor", "predictor/model", "Model predictor", model_predictor_, true));
  config->push_back(CRP("model_agent", "agent", "Agent used for planning episodes", model_agent_));
  
  config->push_back(CRP("state", "state", "Current observed state of planning", CRP::Provided));  
}

void DynaAgent::configure(Configuration &config)
{
  policy_ = (Policy*)config["policy"].ptr();
  predictor_ = (Predictor*)config["predictor"].ptr();

  planning_steps_ = config["planning_steps"];
  planning_horizon_ = config["planning_horizon"];
  threads_ = config["threads"];
  
  model_ = (ObservationModel*)config["model"].ptr();
  model_predictor_ = (ModelPredictor*)config["model_predictor"].ptr();
  model_agent_ = (Agent*)config["model_agent"].ptr();

  state_ = new VectorSignal();
  
  config.set("state", state_);
}

void DynaAgent::reconfigure(const Configuration &config)
{
  if (config.has("action") && config["action"].str() == "reset")
  {
    stopThreads();
    total_planned_steps_ = total_control_steps_ = 0;
    start_obs_.clear();
  }
    
  config.get("planning_steps", planning_steps_);
}

void DynaAgent::start(const Observation &obs, Action *action)
{
  predictor_->finalize();
  
  time_= 0.;
  policy_->act(time_, obs, action);
  
  prev_obs_ = obs;
  prev_action_ = *action;
  start_obs_.add(obs);

  if (threads_ && agent_threads_.empty())
    startThreads();
}

void DynaAgent::step(double tau, const Observation &obs, double reward, Action *action)
{
  time_ += tau;
  policy_->act(time_, obs, action);
  
  Transition t(prev_obs_, prev_action_, tau, reward, obs, *action);
  predictor_->update(t);
  if (model_predictor_)
    model_predictor_->update(t);
  
  if (!threads_)
    runModel();

  prev_obs_ = obs;
  prev_action_ = *action;  

  actual_reward_ += reward;  
  control_steps_++;
  total_control_steps_++;
}

void DynaAgent::end(double tau, const Observation &obs, double reward)
{
  Transition t(prev_obs_, prev_action_, tau, reward, obs);
  predictor_->update(t);
  if (model_predictor_)
    model_predictor_->update(t);
  
  if (!threads_)
    runModel();

  actual_reward_ += reward;  
  control_steps_++;
  total_control_steps_++;
}

void DynaAgent::report(std::ostream &os)
{
  os << std::setw(15) << actual_reward_/control_steps_ << std::setw(15) << planning_reward_/planned_steps_ << std::setw(15) << total_planned_steps_;
  
  planning_reward_ = 0;
  planned_steps_ = 0;
  actual_reward_ = 0;
  control_steps_ = 0;
}

void DynaAgent::runModel()
{
  Observation obs;
  Action action;
  int terminal=1;
  size_t steps=0;

  for (size_t ii=0; ii < planning_steps_; ++ii)
  {
    if (terminal)
    {
      steps = 0;
      obs = start_obs_.draw();
      state_->set(obs.v);
      model_agent_->start(obs, &action);
    }
      
    Observation next;
    double reward;
  
    double tau = model_->step(obs, action, &next, &reward, &terminal);
    
    obs = next;
    state_->set(obs.v);
        
    // Guard against failed model prediction    
    if (obs.size())
    {
      if (terminal == 2)
        model_agent_->end(tau, obs, reward);
      else
        model_agent_->step(tau, obs, reward, &action);
        
      planning_reward_ += reward;
      planned_steps_++;
      total_planned_steps_++;
    }
    else
      terminal = 1;
      
    // Break episodes after a while
    if (planning_horizon_ && steps++ == planning_horizon_)
      terminal = 1;
  }
}

void DynaAgent::startThreads()
{
  for (size_t ii=0; ii < threads_; ++ii)
  {
    agent_threads_.push_back(new DynaAgentThread(this));
    agent_threads_.back()->start();
  }
}

void DynaAgent::stopThreads()
{
  for (size_t ii=0; ii < agent_threads_.size(); ++ii)
  {
    agent_threads_[ii]->stopAndJoin();
    safe_delete(&agent_threads_[ii]);
  }
  
  agent_threads_.clear();
}
