/** \file noise.h
 * \brief Post-policy that injects noise header file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2016-01-21
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

#ifndef GRL_NOISE_POLICY_H_
#define GRL_NOISE_POLICY_H_

#include <grl/policy.h>

namespace grl
{

/// Post-policy that injects noise.
class NoisePolicy : public Policy
{
  public:
    TYPEINFO("mapping/policy/post/noise", "Postprocesses policy output by injecting noise")

  protected:
    Policy *policy_;
    
    double decay_rate_, decay_min_, decay_;
    Vector min_, max_, sigma_, theta_;
    Vector n_;

  public:
    NoisePolicy() : policy_(NULL), decay_rate_(1), decay_min_(0), decay_(1) { }
    
    // From Configurable  
    virtual void request(ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);

    // From Policy
    virtual void act(const Observation &in, Action *out) const;
    virtual void act(double time, const Observation &in, Action *out);
};

}

#endif /* GRL_NOISE_POLICY_H_ */
