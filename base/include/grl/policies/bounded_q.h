/** \file bounded_q.h
 * \brief Bounded Q policy header file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-02-11
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

#ifndef GRL_BOUNDED_Q_POLICY_H_
#define GRL_BOUNDED_Q_POLICY_H_

#include <grl/policies/q.h>

namespace grl
{

/// Q Policy with bounded action deltas.
class BoundedQPolicy : public QPolicy
{
  public:
    TYPEINFO("mapping/policy/value/q/bounded", "Q-value based policy with bounded action deltas")

  protected:
    Vector bound_;

  public:
    // From Configurable
    virtual void request(ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);

    // From QPolicy
    virtual void act(double time, const Observation &in, Action *out);
    virtual void distribution(const Observation &in, const Action &prev, LargeVector *out) const;
    
  protected:
    /// Filter out actions that lie outside bounds.
    void filter(const Vector &in, const Vector &prev_out, const LargeVector &qvalues, LargeVector *filtered, std::vector<size_t> *idx) const;
};

}

#endif /* GRL_BOUNDED_Q_POLICY_H_ */
