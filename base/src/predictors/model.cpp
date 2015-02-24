/** \file model.cpp
 * \brief Model predictor source file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-02-23
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

#include <grl/predictors/model.h>

using namespace grl;

REGISTER_CONFIGURABLE(ModelPredictor)

void ModelPredictor::request(ConfigurationRequest *config)
{
  config->push_back(CRP("wrapping", "Wrapping boundaries", wrapping_));
  config->push_back(CRP("projector", "projector", "Projector for transition model (|S|+|A| dimensions)", projector_));
  config->push_back(CRP("representation", "representation", "Representation for transition model (|S|+2 dimensions)", representation_));
}

void ModelPredictor::configure(Configuration &config)
{
  projector_ = (Projector*)config["projector"].ptr();
  representation_ = (Representation*)config["representation"].ptr();
  
  wrapping_ = config["wrapping"];
}

void ModelPredictor::reconfigure(const Configuration &config)
{
}

ModelPredictor *ModelPredictor::clone() const
{
  ModelPredictor *mp = new ModelPredictor(*this);
  mp->projector_ = projector_->clone();
  mp->representation_= representation_->clone();
  return mp;
}

void ModelPredictor::update(const Transition &transition)
{
  Vector target;
  
  if (!transition.obs.empty())
  {
    target = transition.obs-transition.prev_obs;
    
    for (size_t ii=0; ii < target.size(); ++ii)
      if (wrapping_[ii])
      {
        if (target[ii] > 0.5*wrapping_[ii])
          target[ii] -= wrapping_[ii];
        else if (target[ii] < -0.5*wrapping_[ii])
          target[ii] += wrapping_[ii];
      }
    
    target.push_back(transition.reward);
    target.push_back(0);
  }
  else
  {
    // Absorbing state
    target = transition.prev_obs;
    target.push_back(transition.reward);
    target.push_back(1);
  }
  
  ProjectionPtr p = projector_->project(extend(transition.prev_obs, transition.prev_action));
  representation_->write(p, target);
}

void ModelPredictor::finalize()
{
}