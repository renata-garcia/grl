/** \file td.cpp
 * \brief Temporal difference agent source file.
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

#include <grl/agents/td.h>

using namespace grl;

REGISTER_CONFIGURABLE(TDAgent)

void TDAgent::request(ConfigurationRequest *config)
{
  config->push_back(CRP("policy", "mapping/policy", "Control policy", policy_));
  config->push_back(CRP("predictor", "predictor", "Value function predictor", predictor_));
}

void TDAgent::configure(Configuration &config)
{
  policy_ = (Policy*)config["policy"].ptr();
  predictor_ = (Predictor*)config["predictor"].ptr();
}

void TDAgent::reconfigure(const Configuration &config)
{
}

void TDAgent::start(const Observation &obs, Action *action)
{
  TDAgentState *state = agent_state_.instance();

  predictor_->finalize();

  state->time = 0;
  policy_->act(state->time, obs, action);
  
  state->prev_obs = obs;
  state->prev_action = *action;
}

void TDAgent::step(double tau, const Observation &obs, double reward, Action *action)
{
  TDAgentState *state = agent_state_.instance();

  state->time += tau;
  policy_->act(state->time, obs, action);
  
  predictor_->update(Transition(state->prev_obs, state->prev_action, tau, reward, obs, *action));

  state->prev_obs = obs;
  state->prev_action = *action;
}

void TDAgent::end(double tau, const Observation &obs, double reward)
{
  TDAgentState *state = agent_state_.instance();

  predictor_->update(Transition(state->prev_obs, state->prev_action, tau, reward, obs));
}
