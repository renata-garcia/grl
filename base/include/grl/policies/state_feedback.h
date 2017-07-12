/** \file state_feedback.h
 * \brief State feedback policy header file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-08-27
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

#ifndef GRL_STATE_FEEDBACK_POLICY_H_
#define GRL_STATE_FEEDBACK_POLICY_H_

#include <grl/policies/parameterized.h>

namespace grl
{

/// State feedback policy
class StateFeedbackPolicy : public ParameterizedPolicy
{
  public:
    TYPEINFO("mapping/policy/parameterized/state_feedback", "Parameterized policy based on a state feedback controller")

  protected:
    Vector operating_state_, operating_action_;
    LargeVector gains_;
    Vector min_, max_;

  public:
    StateFeedbackPolicy() { }
  
    // From Configurable
    virtual void request(ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);
    virtual StateFeedbackPolicy &copy(const Configurable &obj);

    // From Policy
    virtual void act(const Observation &in, Action *out) const;
    
    // From ParameterizedPolicy
    virtual size_t size() const { return gains_.size(); }
    virtual const LargeVector &params() const { return gains_; }
    virtual void setParams(const LargeVector &params) { gains_ = params; }
    
    virtual void feedforward(const Vector &ff) { operating_action_ = ff; }
};

/// State feedback policy defined over samples
class SampleFeedbackPolicy : public Policy
{
  public:
    TYPEINFO("mapping/policy/sample_feedback", "Policy based on state feedback controller defined over samples")
    
    struct Sample
    {
      Vector x, u;
      Matrix L;
      
      Sample(const Vector &_x, const Vector &_u, const Matrix &_L) : x(_x), u(_u), L(_L) { }
    };

  protected:
    std::vector<Sample> samples_;
    Vector min_, max_;

  public:
    SampleFeedbackPolicy() { }
  
    // From Configurable
    virtual void request(ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);
    virtual SampleFeedbackPolicy &copy(const Configurable &obj);

    // From Policy
    virtual void act(const Observation &in, Action *out) const;

    virtual void clear();
    virtual void push(const Sample &sample);
};

}

#endif /* GRL_STATE_FEEDBACK_POLICY_H_ */
