/** \file split.h
 * \brief Split projector header file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2017-02-09
 *
 * \copyright \verbatim
 * Copyright (c) 2017, Wouter Caarls
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

#ifndef GRL_SPLIT_PROJECTOR_H_
#define GRL_SPLIT_PROJECTOR_H_

#include <grl/discretizer.h>
#include <grl/projector.h>

namespace grl
{

/// Splits a vector projection into distinct features according to a single-element index projection
class SplitProjector : public Projector
{
  public:
    TYPEINFO("projector/split", "Splits a feature vector into distinct sets")
    
  protected:
    Vector index_;
    Discretizer *discretizer_;
    Projector* projector_;
    size_t projector_memory_;

  public:
    SplitProjector() : discretizer_(NULL), projector_(NULL), projector_memory_(0) { }
  
    // From Configurable
    virtual void request(const std::string &role, ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);

    // From Projector
    virtual ProjectionLifetime lifetime() const { return projector_->lifetime(); }
    virtual ProjectionPtr project(const Vector &in) const;
};

}

#endif /* GRL_SPLIT_PROJECTOR_H_ */
