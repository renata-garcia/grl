/** \file mapping.cpp
 * \brief Mapping visualization source file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-02-14
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

#include <GL/gl.h>
#include <GL/glu.h>

#include <grl/visualizations/mapping.h>

#define EPS 0.001

using namespace grl;

REGISTER_CONFIGURABLE(MappingVisualization) 

void MappingVisualization::request(ConfigurationRequest *config)
{
  FieldVisualization::request(config);

  config->push_back(CRP("mapping", "mapping", "Mapping", mapping_));
  
  config->push_back(CRP("output_dim", "Output dimension to visualize", (int)dim_, CRP::Online, 0));
}

void MappingVisualization::configure(Configuration &config)
{
  if (!Visualizer::instance())
  {
    WARNING("visualization/field/mapping requires a configured visualizer to run");
    return;
  }
  
  FieldVisualization::configure(config);
  
  mapping_ = (Mapping*)config["mapping"].ptr();
  
  dim_ = config["output_dim"];
  
  // Create window  
  create(path().c_str());
  
  // Let's get this show on the road
  start();
}

void MappingVisualization::reconfigure(const Configuration &config)
{
  FieldVisualization::reconfigure(config);
  
  config.get("output_dim", dim_);
}

double MappingVisualization::value(const Vector &in) const
{
  Vector output;
  mapping_->read(in, &output);
  
  return output[dim_];
}
