/** \file multi.h
 * \brief Policy combiner header file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2018-03-13
 *
 * \copyright \verbatim
 * Copyright (c) 2018, Wouter Caarls
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

#ifndef GRL_MULTI_POLICY_H_
#define GRL_MULTI_POLICY_H_

#include <grl/policy.h>
#include <grl/discretizer.h>
#include <grl/sampler.h>
#include <grl/signal.h>
#include <grl/vector.h>

#define ASC 0
#define DESC 1

namespace grl
{

/// Policy that combines two or more sub-policies using different strategies
class MultiPolicy : public Policy
{
  public:
    TYPEINFO("mapping/policy/multi", "Combines multiple policies")
    
    enum CombinationStrategy {csBinning,
    csDensityBased, csDensityBasedMeanMov, csDensityBasedBestMov, csDensityBasedVotingMov, csDensityBasedHistoric, csDensityBasedHistoricDens, csDensityBasedDensBest,
    csDataCenter, csDataCenterMeanMov, csDataCenterBestMov, csDataCenterVotingMov, csDataCenterVotingMovTwoSteps,
    csMean, csMeanMov, csRandom, csStatic, csValueBased, csRoulette};

  protected:
    std::string strategy_str_;
    CombinationStrategy strategy_;
    Projector *projector_;
    Representation *representation_;
    Vector min_, max_;
    TypedConfigurableList<Policy> policy_;
    TypedConfigurableList<Mapping> value_;
    int bins_;
    int data_center_mean_size_;
    int static_policy_;
    double r_distance_parameter_;
    double alpha_mov_mean_;
    double minor_remove_bound_;
    double major_remove_bound_;
    VectorSignal *action_;
    Sampler *sampler_;
    std::vector<double> *mean_mov_;
    std::vector<double> *voting_policies_;
    LargeVector last_action_;
    double iRoulette_;
    uint32_t iterations_;
    struct data {
      double value;
      size_t id;
	};

  public:
    MultiPolicy() : bins_(10),
                    data_center_mean_size_(2),
                    static_policy_(0),
                    r_distance_parameter_(0.005),
                    alpha_mov_mean_(0.01),
                    minor_remove_bound_(0.25),
                    major_remove_bound_(0.75),
                    iRoulette_(0.3),
                    iterations_(0)
    {
      srand(time(0));
    }
  
    // From Configurable
    virtual void request(ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);

    // From Policy
    virtual void act(double time, const Observation &in, Action *out);

    // From Multi Policy
    virtual std::vector<size_t> choosing_bests_of_mean_mov(std::vector<Action> &in, int asc_desc) const;
    virtual std::vector<size_t> choosing_quartile_of_mean_mov(std::vector<Action> &in) const;
    static bool compare_asc_value_with_id(const data &a, const data &b);
    static bool compare_desc_value_with_id(const data &a, const data &b);
    virtual void get_max_index(double dist, size_t i, double &max, std::vector<size_t> &i_max_density) const;
    virtual size_t get_max_index_by_density_based(const std::vector<Action> &policies_aa) const;
    virtual size_t get_max_index_by_density_based(const std::vector<Action> &policies_aa, std::vector<double> &density) const;
    virtual size_t get_max_index_by_euclidian_distance(const std::vector<Action> &policies_aa, LargeVector mean) const;
    virtual LargeVector get_mean(const std::vector<Action> &policies_aa) const;
    virtual void get_min_index(double dist, size_t i, double &min, std::vector<size_t> &i_min_density) const;
    virtual LargeVector get_policy_mean(const Observation &in, std::vector<Action> &policies_aa, LargeVector &values) const;
    virtual size_t get_random_index(const std::vector<size_t> &i_max_density) const;
    virtual void update_mean_mov(const std::vector<double> &in) const;
    virtual void update_mean_mov_with_euclidian(const std::vector<Action> &in, LargeVector center) const;
    virtual void update_voting_preferences_ofchoosen_mean_mov(const std::vector<Action> &in, size_t ind) const;
};

/// Policy that combines two or more sub-policies using different strategies
class DiscreteMultiPolicy : public DiscretePolicy
{
  public:
    TYPEINFO("mapping/policy/discrete/multi", "Combines multiple discrete policies")
    
    enum CombinationStrategy {csAddProbabilities, csMultiplyProbabilities, csMajorityVotingProbabilities, csRankVotingProbabilities, csDensityBased};

  protected:
    std::string strategy_str_;
    CombinationStrategy strategy_;
    Discretizer *discretizer_;
    TypedConfigurableList<DiscretePolicy> policy_;
    Vector min_, max_;
    double tau_;
    double r_distance_parameter_;

  public:
    DiscreteMultiPolicy() : tau_(0.1), r_distance_parameter_(0.001) { }
  
    // From Configurable
    virtual void request(ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);

    // From Policy
    virtual void act(const Observation &in, Action *out) const;
    virtual void act(double time, const Observation &in, Action *out);
    
    // From DiscretePolicy
    virtual void distribution(const Observation &in, const Action &prev, LargeVector *out) const;
    
  protected:
    virtual void softmax(const LargeVector &values, LargeVector *distribution) const;
    virtual void normalized_function(const LargeVector &values, LargeVector *distribution) const;
};

}

#endif /* GRL_MULTI_POLICY_H_ */
