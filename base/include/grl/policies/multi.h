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
#include <tuple>

#define ASC 0
#define DESC 1

/*
mpol_dpg_13_alg4steps.yaml

case csDataCenterVotingMov:
{
  std::vector<double>::iterator itd;
	std::vector<double> voting_weights(n_policies);
	std::vector<double> voting_weights_id_kepper(n_policies);
  LargeVector mean, vals;
  for(size_t i=0; i < voting_weights.size(); ++i)
	voting_weights[i] = 1 + iRoulette_*(n_policies-1);

  mean = get_policy_mean(in, actions_actors, vals);
  
  update_mean_mov_with_euclidian(actions_actors, mean);

  std::vector<size_t> v_id = choosing_quartile_of_mean_mov(actions_actors);
  
  for(size_t k = 0; k < v_id.size(); ++k)
  {
	voting_weights_id_kepper[v_id[k]] = -1;
	voting_weights[v_id[k]] = voting_weights[v_id[k]] - (v_id.size() - k)*iRoulette_;
  }

  for(size_t i=0, k=0; i < voting_weights_id_kepper.size(); ++i)
	if(voting_weights_id_kepper[i] >= 0)
	  voting_weights_id_kepper[i] = k++;

  while(actions_actors.size() > data_center_mean_size_)
  {
	size_t index = get_max_index_by_euclidian_distance(actions_actors, mean);
	actions_actors.erase(actions_actors.begin()+index); //retirando apenas o elemento que está no index i_max
	//atualizando o vetor de voting_weights conforme escolha de retirada
	bool found = false;
	for(size_t i = 0; i < n_policies; ++i)
	{
	  if(voting_weights_id_kepper[i] == index){
		voting_weights_id_kepper[i] = -1;
		found = true;
	  } else if(found)
		voting_weights_id_kepper[i]--;
	}
	for(size_t i = 0; i < voting_weights.size(); ++i)
	  if(voting_weights_id_kepper[i] < 0)
		voting_weights[i] = voting_weights[i] - iRoulette_;

	mean = get_mean(actions_actors);
  }
  for(size_t k = 0; k < v_id.size(); ++k)
	voting_weights[v_id[k]] = 1;

  update_mean_mov(voting_weights);      
  dist = mean;
}
break;
case csDataCenterVotingMovTwoSteps:
{
  std::vector<double>::iterator itd;
  std::vector<double> voting_weights(n_policies);
  std::vector<double> voting_weights_id_kepper(n_policies);
  LargeVector mean, vals, mean2;
  std::vector<Action> aa_copied(n_policies);
  for(size_t i=0; i < voting_weights.size(); ++i)
  {
	voting_weights[i] = 1 + iRoulette_*(n_policies-1);
	voting_weights_id_kepper[i] = i;
  }

  mean = get_policy_mean(in, actions_actors, vals);
  
  for(size_t i = 0; i < actions_actors.size(); ++i)
  {
	aa_copied[i].v.resize(actions_actors[i].v.size());
	for (size_t ii = 0; ii < actions_actors[i].v.size(); ++ii)
	  aa_copied[i].v[ii] = actions_actors[i].v[ii];
  }

  mean2.resize(mean.size());
  for (size_t ii = 0; ii < mean.size(); ++ii)
	mean2[ii] = mean[ii];

  //PART 1
  
  while(actions_actors.size() > data_center_mean_size_)
  {
	size_t index = get_max_index_by_euclidian_distance(actions_actors, mean);
	actions_actors.erase(actions_actors.begin()+index); //retirando apenas o elemento que está no index i_max

	//atualizando o vetor de voting_weights conforme escolha de retirada
	bool found = false;
	for(size_t i = 0; i < n_policies; ++i)
	{
	  if(voting_weights_id_kepper[i] == index){
		voting_weights_id_kepper[i] = -1;
		found = true;
	  } else if(found)
		voting_weights_id_kepper[i]--;
	}
	for(size_t i = 0; i < voting_weights.size(); ++i)
	  if(voting_weights_id_kepper[i] < 0)
		voting_weights[i] = voting_weights[i] - iRoulette_;

	mean = get_mean(actions_actors);
  }

  update_mean_mov(voting_weights); 

  //PART 2
  update_mean_mov_with_euclidian(actions_actors, mean);

  std::vector<size_t> v_id = choosing_bests_of_mean_mov(aa_copied, ASC);

  //initing voting vectors
  for(size_t i = 0; i < voting_policies_->size(); ++i)
  {
	voting_policies_->at(i) = 1;
	voting_weights_id_kepper[i] = i;
  }

  for(size_t i=0; i < voting_weights.size(); ++i)
	voting_weights[i] = 1 + iRoulette_*(n_policies-1);

  for(size_t k = 0; k < v_id.size(); ++k)
  {
	voting_weights_id_kepper[v_id[k]] = -1;
	voting_weights[v_id[k]] = voting_weights[v_id[k]] - (v_id.size() - k)*iRoulette_;
  }

  for(size_t i=0, k=0; i < voting_weights_id_kepper.size(); ++i)
	if(voting_weights_id_kepper[i] >= 0)
	  voting_weights_id_kepper[i] = k++;

  while(aa_copied.size() > data_center_mean_size_)
  {
	size_t index = get_max_index_by_euclidian_distance(aa_copied, mean2);
	aa_copied.erase(aa_copied.begin()+index); //retirando apenas o elemento que está no index i_max
	//atualizando o vetor de voting_weights conforme escolha de retirada
	bool found = false;
	for(size_t i = 0; i < n_policies; ++i)
	{
	  if(voting_weights_id_kepper[i] == index){
		voting_weights_id_kepper[i] = -1;
		found = true;
	  } else if(found)
		voting_weights_id_kepper[i]--;
	}
	for(size_t i = 0; i < voting_weights.size(); ++i)
	  if(voting_weights_id_kepper[i] < 0)
		voting_weights[i] = voting_weights[i] - iRoulette_;

	mean2 = get_mean(aa_copied);
  }
  for(size_t k = 0; k < v_id.size(); ++k)
	voting_weights[v_id[k]] = 1;

  dist = mean2;
}
break;
*/

namespace grl
{

/// Policy that combines two or more sub-policies using different strategies
class MultiPolicy : public Policy
{

  public:
    TYPEINFO("mapping/policy/multi", "Combines multiple policies")
    
    typedef std::vector<Action> ActionArray;
  
    enum CombinationStrategy {csBinning,
    csDensityBased, csDensityBasedMeanMov, csDensityBasedBestMov, csDensityBasedVotingMov, csDensityBasedHistoric, csDensityBasedHistoricDens, csDensityBasedDensBest,
    csDataCenter, csDataCenterMeanMov, csDataCenterBestMov, csDataCenterVotingMov, csDataCenterVotingMovTwoSteps,
    csAlg4StepsNew, csAlg4Steps,
    csMean, csMeanMov, csRandom, csStatic, csValueBased, csRoulette};
    enum ScoreDistance {sdNone, sdDensityBased, sdDataCenter, sdMean};
    enum UpdateHistory {uhNone, uhEuclidianDistance, uhDensity, uhVoting};
    enum ChooseActions {caNone, caMax, caMin, ca50PercAsc, ca50PercDesc, ca25Perc, ca10Perc, caQuartileOfMeanMov};

  protected:
    std::string strategy_str_;
    std::string score_distance_str_;
    std::string update_history_str_;
    std::string choose_actions_str_;
    std::string select_by_distance_str_;
    CombinationStrategy strategy_;
    ScoreDistance score_distance_;
    UpdateHistory update_history_;
    UpdateHistory score_;
    ChooseActions choose_actions_;
    ///////////////////////////////
    ScoreDistance ensemble_mean_;
    UpdateHistory scores_;
    ScoreDistance select_;
    ///////////////////////////////
    ScoreDistance select_by_distance_;
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
    struct node {
      LargeVector action;
      LargeVector normalized;
      double mean_mov_i;
      double score;
      size_t id;
	  };
    //------------------------------------------------------
    double percentile_;

  public:
    MultiPolicy() : bins_(10),
                    data_center_mean_size_(2),
                    static_policy_(0),
                    r_distance_parameter_(0.005),
                    alpha_mov_mean_(0.01),
                    minor_remove_bound_(0.25),
                    major_remove_bound_(0.75),
                    iRoulette_(0.3),
                    iterations_(0),
                    percentile_(1.)
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
    virtual size_t get_max_index_by_density_based(const std::vector<Action> &policies_aa, std::vector<double> *density) const;
    virtual size_t get_max_index_by_euclidian_distance(const std::vector<Action> &policies_aa, LargeVector mean) const;
    virtual LargeVector get_mean(const std::vector<Action> &policies_aa) const;
    virtual void get_min_index(double dist, size_t i, double &min, std::vector<size_t> &i_min_density) const;
    virtual LargeVector get_policy_mean(const Observation &in, std::vector<Action> &policies_aa, LargeVector &values) const;
    virtual LargeVector get_policy_mean(const Observation &in, std::vector<node> *policies_aa, LargeVector *values) const;
    virtual size_t get_random_index(const std::vector<size_t> &i_max_density) const;
    virtual void update_mean_mov(const std::vector<double> &in) const;
    virtual void update_mean_mov_with_euclidian(const std::vector<Action> &in, LargeVector center) const;
    virtual void update_voting_preferences_ofchoosen_mean_mov(const std::vector<Action> &in, size_t ind) const;

    // virtual size_t score_distance_density_based(std::vector<node> *action_actors) const;
    virtual LargeVector score_distance_data_center(std::vector<node> *in, LargeVector center) const;
    virtual void choosing_quartile_of_mean_mov(std::vector<node> *in) const;
    virtual void set_density_based(std::vector<node> *in) const;
    virtual LargeVector get_mean(const std::vector<node> &in) const;
    virtual void update_mean_mov(std::vector<node> *in) const;
    virtual void choosing_first50perc_of_mean_mov(std::vector<node> *in, int asc_desc) const;
    static bool compare_asc_mean_mov_i(const node &a, const node &b);
    static bool compare_desc_mean_mov_i(const node &a, const node &b);
    virtual void set_euclidian_distance(std::vector<node> *in, LargeVector mean) const;
    virtual size_t get_max_index(const std::vector<node> &in) const;
    virtual size_t get_min_index(const std::vector<node> &in) const;

    //trying again
    virtual LargeVector mean(ActionArray const &array) const;
    virtual LargeVector score(ActionArray const &array, double mean) const;
    virtual ActionArray percentile(ActionArray const &array, double percentile) const;
    virtual std::vector<double> set_density_based(ActionArray &actions_actors) const;
    virtual size_t get_max_index(const std::vector<double> &in) const;
 
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
