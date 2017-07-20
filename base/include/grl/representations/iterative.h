/** \file dmp.h
 * \brief Iterative representation header file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2016-07-03
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

#ifndef GRL_ITERATIVE_REPRESENTATION_H_
#define GRL_ITERATIVE_REPRESENTATION_H_

#include <grl/representation.h>

namespace grl
{

/// Representation that iteratively trains a sub-representation (NN epochs).
class IterativeRepresentation : public Representation
{
  public:
    TYPEINFO("representation/iterative", "Representation that iteratively trains a sub-representation")
    
    typedef std::pair<ProjectionPtr, Vector> Sample;
    typedef std::vector<Sample> SampleVector;
    
  protected:
    int epochs_, cumulative_, batch_size_;
    Representation* representation_;
    SampleVector samples_;
    
  public:
    IterativeRepresentation() : epochs_(5000), cumulative_(1), batch_size_(0), representation_(NULL) { }
    
    // From Configurable
    virtual void request(const std::string &role, ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);
  
    // From Representation
    virtual double read(const ProjectionPtr &projection, Vector *result, Vector *stddev) const
    {
      return representation_->read(projection, result, stddev);
    }
    
    virtual void write(const ProjectionPtr projection, const Vector &target, const Vector &alpha);
    virtual void update(const ProjectionPtr projection, const Vector &delta)
    {
      throw Exception("Can not update iterative representation");
    }
    
    virtual void finalize();
};

}

#endif /* GRL_ITERATIVE_REPRESENTATION_H_ */
