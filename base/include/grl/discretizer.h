/** \file discretizer.h
 * \brief Generic discretizer definition.
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

#ifndef GRL_DISCRETIZER_H_
#define GRL_DISCRETIZER_H_

#include <grl/configurable.h>

namespace grl
{

/// Provides a list of discrete points spanning a continuous space.
class Discretizer : public Configurable
{
  public:
    virtual ~Discretizer() { }
    
    /// List of discrete points.
    virtual void options(std::vector<Vector> *out) const
    {
      options(Vector(), out);
    }
    
    virtual void options(const Vector &point, std::vector<Vector> *out) const
    {
      out->clear();
      out->reserve(size(point));
      for (iterator it=begin(point); it != end(); ++it)
        out->push_back(*it);
    }
    
    /// Iterates over discrete points.
    class iterator
    {
      protected:
        const Discretizer *discretizer_;
        
      public:
        Vector point;
        IndexVector idx;

      public:
        iterator(const Discretizer *discretizer=NULL, Vector _point=Vector(), IndexVector _idx=IndexVector()) : discretizer_(discretizer), point(_point), idx(_idx) { }
        inline bool operator==(const iterator &rhs) const { return idx.size() == rhs.idx.size() && (idx == rhs.idx).all(); }
        inline bool operator!=(const iterator &rhs) const { return idx.size() != rhs.idx.size() || (idx != rhs.idx).any(); }
        inline iterator &operator++() { discretizer_->inc(this); return *this; }
        inline Vector operator*() { return discretizer_->get(*this); }
    };

    virtual size_t size() const { return size(Vector()); }
    virtual size_t size(const Vector &point) const { return size(); }
    virtual iterator begin() const { return begin(Vector()); }
    virtual iterator begin(const Vector &point) const { return begin(); }
    virtual iterator end() const
    {
      return iterator(this);
    }
    
    virtual void   inc(iterator *it) const = 0;
    virtual Vector get(const iterator &it) const = 0;
    virtual Vector at(size_t idx) const { return at(Vector(), idx); }
    virtual Vector at(const Vector &point, size_t idx) const { return at(idx); }

    /// Finds the closest point to vec.
    /// NOTE: should take point argument, like other member functions.
    virtual size_t discretize(const Vector &vec) const = 0;
};

}

#endif /* GRL_DISCRETIZER_H_ */
