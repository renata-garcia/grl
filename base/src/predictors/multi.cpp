/** \file multi.cpp
 * \brief Multi predictor source file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2016-09-01
 *
 * \copyright \verbatim
 * Copyright (c) 2016, Wouter Caarls
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

#include <grl/predictors/multi.h>

using namespace grl;

REGISTER_CONFIGURABLE(MultiPredictor)

void MultiPredictor::request(ConfigurationRequest *config)
{
  config->push_back(CRP("predictor", "predictor", "First downstream predictor", &predictor_));
}

void MultiPredictor::configure(Configuration &config)
{
  predictor_ = *((ConfigurableList*)config["predictor"].ptr());
}

void MultiPredictor::reconfigure(const Configuration &config)
{
}

void MultiPredictor::update(const Transition &transition)
{
  for (size_t ii=0; ii < predictor_.size(); ++ii)
    predictor_[ii]->update(transition);
}

void MultiPredictor::update(const std::vector<const Transition*> &transitions)
{
  for (size_t ii=0; ii < predictor_.size(); ++ii)
    predictor_[ii]->update(transitions);
}

void MultiPredictor::finalize()
{
  for (size_t ii=0; ii < predictor_.size(); ++ii)
    predictor_[ii]->finalize();
}
