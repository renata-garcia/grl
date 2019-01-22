/** \file multi.cpp
 * \brief Combining policy source file. 
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

#include <grl/policies/multi.h>
#include <queue>

using namespace grl;

REGISTER_CONFIGURABLE(MultiPolicy)

void MultiPolicy::request(ConfigurationRequest *config)
{
  config->push_back(CRP("strategy", "Combination strategy", strategy_str_, CRP::Configuration,
  {"binning",
  "density_based", "density_based_mean_mov", "density_based_best_mov", "density_based_voting_mov", "density_based_historic", "density_based_historic_dens",
  "data_center", "data_center_mean_mov", "data_center_best_mov", "data_center_voting_mov", "data_center_voting_mov_two_steps",
  "mean", "mean_mov", "random", "static", "value_based", "roulette"}));
  config->push_back(CRP("sampler", "sampler", "Sampler for value-based strategy", sampler_, true));
  config->push_back(CRP("bins", "Binning Simple Discretization", bins_));
  config->push_back(CRP("static_policy", "Static Policy Chosen to Learning", static_policy_));
  config->push_back(CRP("r_distance_parameter", "R Distance Parameter", r_distance_parameter_));
  config->push_back(CRP("alpha", "Alpha Moving Mean", alpha_mov_mean_));
  config->push_back(CRP("iroulette", "Increment of Roulette Strategy", iRoulette_));
  config->push_back(CRP("minor_remove_bound", "Minor Remove Bound", minor_remove_bound_));
  config->push_back(CRP("major_remove_bound", "Major Remove Bound", major_remove_bound_));

  config->push_back(CRP("policy", "mapping/policy", "Sub-policies", &policy_));
  config->push_back(CRP("value", "mapping", "Values of sub-policy actions", &value_, true));
  
  config->push_back(CRP("output_min", "vector.action_min", "Lower limit on outputs", min_, CRP::System));
  config->push_back(CRP("output_max", "vector.action_max", "Upper limit on outputs", max_, CRP::System));

  config->push_back(CRP("actions", "signal/vector.action", "Suggested actions", CRP::Provided));
}

void MultiPolicy::configure(Configuration &config)
{
  strategy_str_ = config["strategy"].str();
  if (strategy_str_ == "binning")
    strategy_ = csBinning;
  else if (strategy_str_ == "density_based")
    strategy_ = csDensityBased;
  else if (strategy_str_ == "density_based_mean_mov")
    strategy_ = csDensityBasedMeanMov;
  else if (strategy_str_ == "density_based_best_mov")
    strategy_ = csDensityBasedBestMov;
  else if (strategy_str_ == "density_based_voting_mov")
    strategy_ = csDensityBasedVotingMov;
  else if (strategy_str_ == "density_based_historic")
    strategy_ = csDensityBasedHistoric;
  else if (strategy_str_ == "density_based_historic_dens")
    strategy_ = csDensityBasedHistoricDens;
  else if (strategy_str_ == "data_center")
    strategy_ = csDataCenter;
  else if (strategy_str_ == "data_center_mean_mov")
    strategy_ = csDataCenterMeanMov;
  else if (strategy_str_ == "data_center_best_mov")
    strategy_ = csDataCenterBestMov;
  else if (strategy_str_ == "data_center_voting_mov")
  	strategy_ = csDataCenterVotingMov;
  else if (strategy_str_ == "data_center_voting_mov_two_steps")
  	strategy_ = csDataCenterVotingMovTwoSteps;
  else if (strategy_str_ == "mean")
    strategy_ = csMean;
  else if (strategy_str_ == "mean_mov")
    strategy_ = csMeanMov;
  else if (strategy_str_ == "random")
    strategy_ = csRandom;
  else if (strategy_str_ == "static")
    strategy_ = csStatic;
  else if (strategy_str_ == "value_based")
    strategy_ = csValueBased;
  else if (strategy_str_ == "roulette")
    strategy_ = csRoulette;
  else
    throw bad_param("mapping/policy/multi:strategy");

  sampler_ = (Sampler*)config["sampler"].ptr();

  bins_ = config["bins"];

  static_policy_ = config["static_policy"];
  if (static_policy_ >= 0 && static_policy_ < policy_.size())
    throw bad_param("policy/static_policy:static_policy is out of bound");

  r_distance_parameter_ = config["r_distance_parameter"];
  alpha_mov_mean_ = config["alpha"];
  iRoulette_ = config["iroulette"];
  minor_remove_bound_ = config["minor_remove_bound"];
  major_remove_bound_ = config["major_remove_bound"];

  min_ = config["output_min"].v();
  max_ = config["output_max"].v();
  if (min_.size() != max_.size() || !min_.size())
    throw bad_param("policy/action:{output_min,output_max}");

  policy_ = *(ConfigurableList*)config["policy"].ptr();
  value_ = *(ConfigurableList*)config["value"].ptr();
  
  if (policy_.empty())
    throw bad_param("mapping/policy/multi:policy is empty");

  mean_mov_ = new std::vector<double>(policy_.size());
  voting_policies_ = new std::vector<double>(policy_.size());
  for(size_t i = 0; i < voting_policies_->size(); ++i)
    voting_policies_->at(i) = 1;

  action_ = new VectorSignal();  
  config.set("actions", action_);

  if (strategy_str_ == "data_center_voting_mov")
  {
    for(size_t i=0; i < policy_.size(); ++i)
      mean_mov_->at(i) = 0.1;
  }

  iterations_ = 0;
}

void MultiPolicy::reconfigure(const Configuration &config)
{
}

void MultiPolicy::act(double time, const Observation &in, Action *out)
{
  iterations_++;
  CRAWL("MultiPolicy::act::in::pt_iterations_: " << iterations_);
  Action tmp_action;
  LargeVector dist;
  int n_policies = policy_.size();
  std::vector<Action> actions_actors(n_policies);
  std::vector<Action> aa_dist();
  policy_[0]->act(in, &actions_actors[0]);
  int n_dimension = actions_actors[0].v.size();
  if (iterations_ == 1)
    last_action_ = LargeVector::Zero(n_dimension);
  Vector send_actions(n_policies);
  
  switch (strategy_)
  {
    case csBinning:
    {
      std::vector<size_t> ii_max_density;
      double* actions_actors = new double[policy_.size()];
      
      CRAWL("MultiPolicy::csBinning histogram");

      double* histogram = new double[bins_];
      for (size_t ii=0; ii < bins_; ++ii)
          histogram[ii] = 0;
      double* result_nd = new double[n_dimension];
      for (size_t jj=0; jj < n_dimension; ++jj)
      {
        CRAWL("MultiPolicy:: min_["<< jj <<"]): " << min_[jj] << ", max_["<< jj <<"]): " << max_[jj] << "\n");
        for (size_t ii=0; ii != policy_.size(); ++ii)
        {
          policy_[ii]->act(in, &tmp_action);
          actions_actors[ii] = tmp_action.v[jj];
          histogram[std::min((int)floor(bins_ * (actions_actors[ii] - min_[jj]) / (max_[jj] - min_[jj]) ), bins_-1)]++;
          CRAWL("MultiPolicy::(*a["<< ii <<"]["<< jj <<"]): " << actions_actors[ii] << "\n");
        }

        size_t cnt_binmax = 0;
        size_t binmax = 0;
        for (size_t ii=0; ii < bins_; ++ii)
        {
          if (cnt_binmax < histogram[ii])
          {
            cnt_binmax = histogram[ii];
            binmax = ii;
            CRAWL("MultiPolicy::binmax: " << binmax << " - cnt_binmax:" << cnt_binmax << "\n");
          }
          CRAWL("MultiPolicy::histogram[" << ii << "]: " << histogram[ii] << "\n");
        }
        CRAWL("MultiPolicy::binmax: " << binmax << "\n");

        size_t n_binmax = 0;
        size_t i_bin = 0;
        
        result_nd[jj] = 0.0;
        for (size_t ii=0; ii < policy_.size(); ++ii)
        {
          i_bin = std::min((int)floor(bins_ * (actions_actors[ii] - min_[jj]) / (max_[jj] - min_[jj]) ), bins_-1);
          CRAWL("MultiPolicy::i_bin: " << i_bin << "\n");
          CRAWL("MultiPolicy::histogram[binmax]: " << histogram[binmax] << " - histogram[i_bin]: " << histogram[i_bin] << "\n");
          if ( histogram[binmax] == histogram[i_bin] )
          {
            result_nd[jj] += actions_actors[ii];
            CRAWL("MultiPolicy::a[" << ii << "]: " << actions_actors[ii] << "\n");
            ++n_binmax;
          }
        }
        result_nd[jj] = result_nd[jj] / n_binmax;
        CRAWL("MultiPolicy::result_nd: " << result_nd[jj] << " n_binmax: " << n_binmax << "\n");
      }
      dist = ConstantLargeVector(n_dimension, *result_nd);
    }
    break;
        
    case csDensityBased:
    {
      std::vector<size_t> ii_max_density;
      std::vector<Action> aa_normalized(n_policies);
      LargeVector mean, vals;
      
      mean = get_policy_mean(in, actions_actors, vals);
      
      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++it_norm)
        (*it_norm).v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );

      for(size_t i = 0; i < aa_normalized.size(); ++i)
        CRAWL("MultiPolicy::csDensityBased::aa_normalized: " << aa_normalized[i]);

      size_t index = get_max_index_by_density_based(aa_normalized);

      dist = actions_actors[index].v;
    }
    break;

    case csDensityBasedBestMov:
    {
      std::vector<size_t> ii_max_density;
      std::vector<Action> aa_normalized(n_policies);
      LargeVector mean, vals;
      
      mean = get_policy_mean(in, actions_actors, vals);

      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++it_norm)
        (*it_norm).v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );

      update_mean_mov_with_euclidian(actions_actors, mean);
      // euclidian_distance_choosing_quartile_of_mean_mov(actions_actors, last_action_);
      std::vector<size_t> v_id = choosing_bests_of_mean_mov(actions_actors);
      for(size_t i = 0; i < actions_actors.size(); ++i)
        CRAWL("MultiPolicy::csDensityBasedBestMov::actions_actors after euclidian_distance_choosing_quartile_of_mean_mov: " << actions_actors[i]);

      for(size_t i=0; i < v_id.size(); ++i)
        aa_normalized.erase(aa_normalized.begin()+v_id[i]-i);
      CRAWL("MultiPolicy::csDensityBasedBestMov::removed ");
      for(std::vector<Action>::iterator it = aa_normalized.begin(); it!=aa_normalized.end(); ++it)
        CRAWL("MultiPolicy::csDensityBasedBestMov::aa_normalized<after remove>:: " << it->v[0]);

      size_t index = get_max_index_by_density_based(aa_normalized);

      // last_action_ = actions_actors[index].v;
      dist = actions_actors[index].v;
    }
    break;
        
    case csDensityBasedMeanMov:
    {
      std::vector<size_t> ii_max_density;
      std::vector<Action> aa_normalized(n_policies);
      LargeVector mean, vals;
      
      mean = get_policy_mean(in, actions_actors, vals);

      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++it_norm)
        (*it_norm).v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );

      update_mean_mov_with_euclidian(actions_actors, mean);
      // euclidian_distance_choosing_quartile_of_mean_mov(actions_actors, last_action_);
      std::vector<size_t> v_id = choosing_quartile_of_mean_mov(actions_actors);
      for(size_t i = 0; i < actions_actors.size(); ++i)
        CRAWL("MultiPolicy::csDensityBasedMeanMov::actions_actors after euclidian_distance_choosing_quartile_of_mean_mov: " << actions_actors[i]);

      for(size_t i=0; i < v_id.size(); ++i)
        aa_normalized.erase(aa_normalized.begin()+v_id[i]-i);
      CRAWL("MultiPolicy::csDensityBasedMeanMov::removed ");
      for(std::vector<Action>::iterator it = aa_normalized.begin(); it!=aa_normalized.end(); ++it)
        CRAWL("MultiPolicy::csDensityBasedMeanMov::aa_normalized<after remove>:: " << it->v[0]);

      size_t index = get_max_index_by_density_based(aa_normalized);

      // last_action_ = actions_actors[index].v;
      dist = actions_actors[index].v;
    }
    break;
        
    case csDensityBasedVotingMov:
    {
      // std::vector<size_t> ii_max_density;
      // std::vector<Action> aa_normalized(n_policies);
      // LargeVector mean, vals;
      
      // mean = get_policy_mean(in, actions_actors, vals);

      // std::vector<Action>::iterator it_norm = aa_normalized.begin();
      // for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++it_norm)
      //   (*it_norm).v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );

      // size_t index = get_max_index_by_density_based(aa_normalized);
      // update_voting_preferences_ofchoosen_mean_mov(aa_normalized, index);

      // std::vector<size_t> v_id = choosing_quartile_of_mean_mov(actions_actors);
      // for(size_t i = 0; i < actions_actors.size(); ++i)
      //   CRAWL("MultiPolicy::csDensityBasedMeanMov::actions_actors after euclidian_distance_choosing_quartile_of_mean_mov: " << actions_actors[i]);

      // for(size_t i=0; i < v_id.size(); ++i)
      //   aa_normalized.erase(aa_normalized.begin()+v_id[i]-i);
      // CRAWL("MultiPolicy::csDensityBasedMeanMov::removed ");
      // for(std::vector<Action>::iterator it = aa_normalized.begin(); it!=aa_normalized.end(); ++it)
      //   CRAWL("MultiPolicy::csDensityBasedMeanMov::aa_normalized<after remove>:: " << it->v[0]);

      // index = get_max_index_by_density_based(aa_normalized);

      // dist = actions_actors[index].v;
      throw "csDensityBasedVotingMov needs refactory";
    }
    break;
        
    case csDensityBasedHistoric:
    {
      std::vector<size_t> ii_max_density;
      std::vector<Action> aa_normalized(n_policies);
      LargeVector mean, vals;
      
      mean = get_policy_mean(in, actions_actors, vals);
      
      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++it_norm)
        (*it_norm).v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );

      for(size_t i = 0; i < aa_normalized.size(); ++i)
        CRAWL("MultiPolicy::csDensityBasedHistoric::aa_normalized: " << aa_normalized[i]);

      size_t index = get_max_index_by_density_based(aa_normalized);
      CRAWL("MultiPolicy::csDensityBasedHistoric::get_max_index_by_density_based(aa_normalized)::index: " << index);

      update_mean_mov_with_euclidian(actions_actors, actions_actors[index].v);

      double min = std::numeric_limits<double>::infinity();
	    std::vector<size_t> i_min_density;
	    for(size_t i = 0; i < mean_mov_->size(); ++i)
	      get_min_index(mean_mov_->at(i), i, min, i_min_density);
	    index = get_random_index(i_min_density);
	    CRAWL("MultiPolicy::csDensityBasedHistoric::index minimum value: " << index);

      dist = actions_actors[index].v;
	    CRAWL("MultiPolicy::csDensityBasedHistoric::dist: " << dist);
    }
    break;
        
    case csDensityBasedHistoricDens:
    {
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
      std::vector<size_t> ii_max_density;
      std::vector<Action> aa_normalized(n_policies);
      //std::vector<double> density(n_policies);
      LargeVector mean, vals;
      
      mean = get_policy_mean(in, actions_actors, vals);
      
      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++it_norm)
        (*it_norm).v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );

      for(size_t i = 0; i < aa_normalized.size(); ++i)
        CRAWL("MultiPolicy::csDensityBasedHistoricDens::aa_normalized: " << aa_normalized[i]);

      std::vector<double> density(n_policies);
      size_t index = get_max_index_by_density_based(aa_normalized, density);
      CRAWL("MultiPolicy::csDensityBasedHistoricDens::get_max_index_by_density_based(aa_normalized)::index: " << index);

      for(size_t i = 0; i < density.size(); ++i)
        CRAWL("MultiPolicy::csDensityBasedHistoricDens::density[i:" << i << "]: " << density[i]);

      update_mean_mov(density);

      double max = -1 * std::numeric_limits<double>::infinity();
      std::vector<size_t> i_max_density;
      for(size_t i = 0; i < mean_mov_->size(); ++i)
        get_max_index(mean_mov_->at(i), i, max, i_max_density);
      index = get_random_index(i_max_density);
      CRAWL("MultiPolicy::csDensityBasedHistoricDens::index maximum value: " << index);

      dist = actions_actors[index].v;
      CRAWL("MultiPolicy::csDensityBasedHistoricDens::dist: " << dist);
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
    }
    break;

    case csDataCenter:
    {
      CRAWL("MultiPolicy::csDataCenter::starting********************************************************************************");      
      LargeVector mean, vals;

      mean = get_policy_mean(in, actions_actors, vals);
      CRAWL("MultiPolicy::csDataCenter::collecting mean: " << mean);
      
      while(actions_actors.size() > data_center_mean_size_)
      {
  	    size_t index = get_max_index_by_euclidian_distance(actions_actors, mean);
        CRAWL("MultiPolicy::csDataCenter::remove outlier");
        actions_actors.erase(actions_actors.begin()+index); //retirando apenas o elemento que está no index i_max

        for(size_t ii=0; ii < actions_actors.size(); ++ii)  //PRINTLN
          CRAWL("MultiPolicy::after remove the i_max actions_actors: " << actions_actors[ii]);
        
        CRAWL("MultiPolicy::csDataCenter::starting new mean");
        mean = get_mean(actions_actors);
        CRAWL("MultiPolicy::csDataCenter::mean...........: " << mean);
      }

      dist = mean;
    }
    break;
        
    case csDataCenterBestMov:
    {
      CRAWL("MultiPolicy::csDataCenterBestMov::starting********************************************************************************");      
      std::vector<double>::iterator itd;     
      LargeVector mean, vals;

      mean = get_policy_mean(in, actions_actors, vals);
      CRAWL("MultiPolicy::csDataCenterBestMov::collecting mean: " << mean);

      update_mean_mov_with_euclidian(actions_actors, mean);
      choosing_bests_of_mean_mov(actions_actors);
      for(size_t i = 0; i < actions_actors.size(); ++i)
        CRAWL("MultiPolicy::actions_actors after euclidian_distance_choosing_quartile_of_mean_mov: " << actions_actors[i]);
      
      while(actions_actors.size() > data_center_mean_size_)
      {
  	    size_t index = get_max_index_by_euclidian_distance(actions_actors, mean);
        CRAWL("MultiPolicy::csDataCenterBestMov::remove outlier");
        actions_actors.erase(actions_actors.begin()+index); //retirando apenas o elemento que está no index i_max

        for(size_t ii=0; ii < actions_actors.size(); ++ii)  //PRINTLN
          CRAWL("MultiPolicy::after remove the i_max actions_actors: " << actions_actors[ii]);
        
        CRAWL("MultiPolicy::csDataCenterBestMov::starting new mean");
        mean = get_mean(actions_actors);
        CRAWL("MultiPolicy::csDataCenterBestMov::mean...........: " << mean);
      }

      dist = mean;
    }
    break;
        
    case csDataCenterMeanMov:
    {
      CRAWL("MultiPolicy::csDataCenterMeanMov::starting********************************************************************************");      
      std::vector<double>::iterator itd;     
      LargeVector mean, vals;

      mean = get_policy_mean(in, actions_actors, vals);
      CRAWL("MultiPolicy::csDataCenterMeanMov::collecting mean: " << mean);

      update_mean_mov_with_euclidian(actions_actors, mean);
      choosing_quartile_of_mean_mov(actions_actors);
      for(size_t i = 0; i < actions_actors.size(); ++i)
        CRAWL("MultiPolicy::actions_actors after euclidian_distance_choosing_quartile_of_mean_mov: " << actions_actors[i]);
      
      while(actions_actors.size() > data_center_mean_size_)
      {
  	    size_t index = get_max_index_by_euclidian_distance(actions_actors, mean);
        CRAWL("MultiPolicy::csDataCenterMeanMov::remove outlier");
        actions_actors.erase(actions_actors.begin()+index); //retirando apenas o elemento que está no index i_max

        for(size_t ii=0; ii < actions_actors.size(); ++ii)  //PRINTLN
          CRAWL("MultiPolicy::after remove the i_max actions_actors: " << actions_actors[ii]);
        
        CRAWL("MultiPolicy::csDataCenterMeanMov::starting new mean");
        mean = get_mean(actions_actors);
        CRAWL("MultiPolicy::csDataCenterMeanMov::mean...........: " << mean);
      }

      dist = mean;
    }
    break;

    case csDataCenterVotingMov:
    {
      CRAWL("MultiPolicy::csDataCenterVotingMov::starting********************************************************************************");      
      std::vector<double>::iterator itd;
	    std::vector<double> voting_weights(n_policies);
	    std::vector<double> voting_weights_id_kepper(n_policies);
      LargeVector mean, vals;
      for(size_t i=0; i < voting_weights.size(); ++i)
        voting_weights[i] = 1 + iRoulette_*(n_policies-1);

      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMov::voting_weights[i:" << i << "]: " << voting_weights[i]);

      mean = get_policy_mean(in, actions_actors, vals);
      CRAWL("MultiPolicy::csDataCenterVotingMov::collecting mean: " << mean);

      update_mean_mov_with_euclidian(actions_actors, mean);
    
      std::vector<size_t> v_id = choosing_quartile_of_mean_mov(actions_actors);
      for(size_t i=0; i < v_id.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMov::v_id[i:" << i << "]: " << v_id[i]);

      for(size_t k = 0; k < v_id.size(); ++k)
      {
        voting_weights_id_kepper[v_id[k]] = -1;
        voting_weights[v_id[k]] = voting_weights[v_id[k]] - (v_id.size() - k)*iRoulette_;
      }

      for(size_t i=0, k=0; i < voting_weights_id_kepper.size(); ++i)
        if(voting_weights_id_kepper[i] >= 0)
          voting_weights_id_kepper[i] = k++;

      for(size_t i=0; i < voting_weights_id_kepper.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMov::voting_weights_id_kepper[i:" << i << "]: " << voting_weights_id_kepper[i]);

      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMov::voting_weights[i:" << i << "]: " << voting_weights[i]);

      while(actions_actors.size() > data_center_mean_size_)
      {
  	    size_t index = get_max_index_by_euclidian_distance(actions_actors, mean);
        CRAWL("MultiPolicy::csDataCenterVotingMov::remove outlier::index: " << index);
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

      for(size_t i=0; i < voting_weights_id_kepper.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMov::voting_weights_id_kepper[i:" << i << "]: " << voting_weights_id_kepper[i]);

      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMov::voting_weights[i:" << i << "]: " << voting_weights[i]);

        for(size_t ii=0; ii < actions_actors.size(); ++ii)  //PRINTLN
          CRAWL("MultiPolicy::after remove the i_max actions_actors: " << actions_actors[ii]);

        CRAWL("MultiPolicy::csDataCenterVotingMov::starting new mean");
        mean = get_mean(actions_actors);
        CRAWL("MultiPolicy::csDataCenterVotingMov::mean...........: " << mean);
      }
      for(size_t k = 0; k < v_id.size(); ++k)
        voting_weights[v_id[k]] = 1;
      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMov::voting_weights[i:" << i << "]: " << voting_weights[i]);

      update_mean_mov(voting_weights);      
      dist = mean;
    }
    break;

    case csDataCenterVotingMovTwoSteps:
    {
      CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::starting********************************************************************************");    

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

      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights[i:" << i << "]: " << voting_weights[i]);

      mean = get_policy_mean(in, actions_actors, vals);
      CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::collecting mean: " << mean);

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
      CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::PART 1::mean: " << mean);
    
      while(actions_actors.size() > data_center_mean_size_)
      {
  	    size_t index = get_max_index_by_euclidian_distance(actions_actors, mean);
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::remove outlier::index: " << index);
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

        for(size_t i=0; i < voting_weights_id_kepper.size(); ++i)
          CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights_id_kepper[i:" << i << "]: " << voting_weights_id_kepper[i]);

        for(size_t i=0; i < voting_weights.size(); ++i)
          CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights[i:" << i << "]: " << voting_weights[i]);

        for(size_t ii=0; ii < actions_actors.size(); ++ii)  //PRINTLN
          CRAWL("MultiPolicy::after remove the i_max actions_actors: " << actions_actors[ii]);

        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::starting new mean");
        mean = get_mean(actions_actors);
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::mean...........: " << mean);
      }

      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights[i:" << i << "]: " << voting_weights[i]);

      update_mean_mov(voting_weights); 

      //PART 2
      //aa_copied      mean2
      CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::PART 2::mean2: " << mean2);

      update_mean_mov_with_euclidian(actions_actors, mean);
      
      std::vector<size_t> v_id = choosing_bests_of_mean_mov(aa_copied);
      for(size_t i=0; i < v_id.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::v_id[i:" << i << "]: " << v_id[i]);
      
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

      for(size_t i=0; i < voting_weights_id_kepper.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights_id_kepper[i:" << i << "]: " << voting_weights_id_kepper[i]);

      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights[i:" << i << "]: " << voting_weights[i]);

      while(aa_copied.size() > data_center_mean_size_)
      {
  	    size_t index = get_max_index_by_euclidian_distance(aa_copied, mean2);
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::remove outlier::index: " << index);
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

      for(size_t i=0; i < voting_weights_id_kepper.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights_id_kepper[i:" << i << "]: " << voting_weights_id_kepper[i]);

      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights[i:" << i << "]: " << voting_weights[i]);

        for(size_t ii=0; ii < aa_copied.size(); ++ii)  //PRINTLN
          CRAWL("MultiPolicy::after remove the i_max aa_copied: " << aa_copied[ii]);

        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::starting new mean");
        mean2 = get_mean(aa_copied);
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::mean...........: " << mean2);
      }
      for(size_t k = 0; k < v_id.size(); ++k)
        voting_weights[v_id[k]] = 1;
      for(size_t i=0; i < voting_weights.size(); ++i)
        CRAWL("MultiPolicy::csDataCenterVotingMovTwoSteps::voting_weights[i:" << i << "]: " << voting_weights[i]);
     
      dist = mean2;
    }
    break;
    
    case csMean:
    { 
      LargeVector vals;
      dist = get_policy_mean(in, actions_actors, vals);
    }
    break;

    case csMeanMov:
    {
      LargeVector vals;
      update_mean_mov_with_euclidian(actions_actors, get_policy_mean(in, actions_actors, vals));
      choosing_quartile_of_mean_mov(actions_actors);
      
      dist = get_mean(actions_actors);
    }
    break;

    case csRandom:
    {
      int aleatorio = rand();
      size_t policy_random = aleatorio%n_policies;
      policy_[policy_random]->act(in, &tmp_action);
      dist = tmp_action.v;

      CRAWL("MultiPolicy::case csRandom policy_[policy_random: " << policy_random << "]->v: " << dist);
    }
    break;
    
    case csStatic:
    {
      size_t policy_chosen = static_policy_%n_policies;
      policy_[policy_chosen]->act(in, &tmp_action);
      dist = tmp_action.v;
      CRAWL("MultiPolicy::case csStatic policy_[policy_chosen:" << policy_chosen << "]->v: " << dist);
    }
    break;

    case csValueBased:
    {
      Vector dummy;
      LargeVector values = LargeVector::Zero(n_policies);
      dist = LargeVector::Zero(n_dimension);
      
      get_policy_mean(in, actions_actors, values);

      for(size_t i = 0; i != n_policies; ++i)
        CRAWL("MultiPolicy::values[i=" << i << "]: " << values[i]);

      size_t ind = sampler_->sample(values);
      dist = actions_actors[ind].v;
      CRAWL("Multipolicy::-std::tmp_action.v: " << actions_actors[ind].v);
    }
    break;

    case csRoulette:
    {
		LargeVector values = LargeVector::Zero(n_policies);
		double roulette = (rand() % (n_policies*100))/100.;

		get_policy_mean(in, actions_actors, values);

		size_t ind = 0;
		for(size_t i = 0; i < voting_policies_->size(); ++i)
		{
		  CRAWL("MultiPolicy::csRoulette::rouling::roulette: " << roulette << ", voting_policies_->at(i:" << i << "): " << voting_policies_->at(i) );
		  if (roulette <= voting_policies_->at(i))
		  {
		    ind = i;
		    break;
		  }
		  roulette -= voting_policies_->at(i);
		}

		CRAWL("MultiPolicy::csRoulette::updating voting_policies_::ind: " << ind);
		for(size_t i = 0; i < voting_policies_->size(); ++i)
		{
		  CRAWL("MultiPolicy::csRoulette::before::mean_mov(i:" << i << "): " << voting_policies_->at(i));
		  if ((i != ind) && (voting_policies_->at(i) > 0))
		  {
		    voting_policies_->at(ind) = voting_policies_->at(ind) + iRoulette_;
		    voting_policies_->at(i) = voting_policies_->at(i) - iRoulette_;
		  }
		  CRAWL("MultiPolicy::csRoulette::after for::mean_mov(i:" << i << "): " << voting_policies_->at(i));
		}
		dist = actions_actors[ind].v;
    }
    break;
  }

  if (!finite(dist[0]))
  {
    ERROR("Result %f is not finite!" << dist[0]);
    ERROR("n_dimension: " << n_dimension);
  }

  *out = dist;
  out->type = atExploratory;
  
  CRAWL("MultiPolicy::(*out): " << (*out) << "\n");
}

std::vector<size_t> MultiPolicy::choosing_bests_of_mean_mov(std::vector<Action> &in) const
{
  
  for(size_t i = 0; i < in.size(); ++i)
    CRAWL( "MultiPolicy::choosing_bests_of_mean_mov::in[i:" << i << "]: " << in[i]);

  std::vector<data> mean_mov_sorted(0);
  std::vector<double>::iterator it=mean_mov_->begin();
  for (size_t i = 0; i < mean_mov_->size(); ++it, ++i)
  {
    data tmp_data = {*it, i};
    mean_mov_sorted.push_back(tmp_data);
  }

  std::sort(mean_mov_sorted.begin(), mean_mov_sorted.end(), compare_desc_value_with_id);

  for(size_t i = 0; i < mean_mov_sorted.size(); ++i)
    CRAWL( "MultiPolicy::choosing_bests_of_mean_mov::(mean_mov_sorted[i:" << i << "].value: " << mean_mov_sorted[i].value << ", i: " << mean_mov_sorted[i].id);

  std::vector<size_t> v_id(0);
  size_t i_kept = (size_t) in.size()/2;
  for(size_t i=0; i <  i_kept; ++i)
    v_id.push_back(mean_mov_sorted[i].id);
  
  sort(v_id.begin(), v_id.end());
  for(size_t i = 0; i < v_id.size(); ++i)
    CRAWL( "MultiPolicy::choosing_bests_of_mean_mov::v_id[i:" << i << "]: " << v_id[i]);

  for(size_t i = 0; i < v_id.size(); ++i)
    in.erase(in.begin()+ v_id[i] - i);

  for(size_t i = 0; i < in.size(); ++i)
    CRAWL( "MultiPolicy::choosing_bests_of_mean_mov::in[i:" << i << "]: " << in[i]);

  CRAWL("MultiPolicy::choosing_bests_of_mean_mov::in.size(): " << in.size() << ", v_id(): " << v_id.size());

  return v_id;
}

std::vector<size_t> MultiPolicy::choosing_quartile_of_mean_mov(std::vector<Action> &in) const
{
  CRAWL("MultiPolicy:: " << in);
  double bound_quantile[] = {minor_remove_bound_, major_remove_bound_};

  std::vector<double> quantile(0);
  for (std::vector<double>::iterator it=mean_mov_->begin(); it!=mean_mov_->end(); ++it)
  {
    quantile.push_back(*it);
    CRAWL("MultiPolicy::choosing_quartile_of_mean_mov::*it: " << *it);
  }

  std::sort(quantile.begin(), quantile.end());

  double fst = 0;
  double trd = 0;

  for(size_t jj = 0; jj < quantile.size(); ++jj)
    CRAWL("MultiPolicy::quantile[jj:"<< jj <<"]" << quantile[jj]);
  
  double q = bound_quantile[0];
  size_t n  = quantile.size();
  double id = (n - 1) * q;
  size_t lo = floor(id);
  size_t hi = ceil(id);
  double qs = quantile[lo];
  double h  = (id - lo);
  fst = (1.0 - h) * qs + h * quantile[hi];

  q = bound_quantile[1];
  n  = quantile.size();
  id = (n - 1) * q;
  lo = floor(id);
  hi = ceil(id);
  qs = quantile[lo];
  h  = (id - lo);

  trd = (1.0 - h) * qs + h * quantile[hi];
  
  CRAWL("MultiPolicy::fst:" << fst << ", bound_quantile[0]: " << bound_quantile[0]);
  CRAWL("MultiPolicy::trd:" << trd << ", bound_quantile[1]: " << bound_quantile[1]);

  std::vector<double>::iterator itd = mean_mov_->begin();
  std::vector<size_t> v_id(0);
  for (size_t i=0; i < in.size(); ++i, ++itd)
    if ( (fst - *itd > 1E-6) || (*itd - trd > 1E-6) ) //if ( (*itd < fst) || (*itd > trd))
      v_id.push_back(i);

  for(size_t i=0; i < v_id.size(); ++i)
    in.erase(in.begin()+v_id[i]-i);
    
  CRAWL("MultiPolicy::choosing_quartile_of_mean_mov::in.size(): " << in.size() << ", v_id(): " << v_id.size());

  return v_id;
}

bool MultiPolicy::compare_desc_value_with_id(const data &a, const data &b)
{
  // return (a.value < b.value);
  return (a.value > b.value);
}

void MultiPolicy::get_max_index(double dist, size_t i, double &max, std::vector<size_t> &i_max_density) const
{
  if (dist > max)
  {
    max = dist;
    i_max_density.clear();
    i_max_density.push_back(i);
    CRAWL("MultiPolicy::get_max_index:max: " << max << " i_max: " << i);
  } else if (dist == max)
    i_max_density.push_back(i);
}

size_t MultiPolicy::get_max_index_by_density_based(const std::vector<Action> &policies_aa) const
{
  std::vector<double> _dummy_density(policies_aa.size());
  return get_max_index_by_density_based(policies_aa, _dummy_density);
}

size_t MultiPolicy::get_max_index_by_density_based(const std::vector<Action> &policies_aa, std::vector<double> &density) const
{
  double max = -1 * std::numeric_limits<double>::infinity();
  std::vector<size_t> i_max_density;
  int n_dimension = policies_aa[0].v.size();
  for(size_t i = 0; i < policies_aa .size(); ++i)
  {
    std::string strtmp = "";
    double r_dist = 0.0;
    for(size_t j = 0; j < policies_aa.size(); ++j)
    {
      double expoent = 0.0;
      for(size_t jj = 0; jj != n_dimension; ++jj)
      {
        expoent += pow(policies_aa[i].v[jj] - policies_aa[j].v[jj], 2);
        //strtmp += strspace + "expoent(jj:" + std::to_string(jj) + "): " +  std::to_string(expoent) + " (1): " + std::to_string((*it).v[jj]) + " (2): " + std::to_string((*it2).v[jj]) + "\n";
      }
      //strtmp += strspace + strspace + "r_dist(before): " + std::to_string(r_dist) + " expoent: " + std::to_string((-1 * expoent / pow(r_distance_parameter_, 2))) + " exp: " + std::to_string(exp( -1 * expoent / pow(r_distance_parameter_, 2))) + "\n";
      r_dist = r_dist + exp( -1 * expoent / pow(r_distance_parameter_, 2) );
    }
    //CRAWL(strtmp << strspace << "sum(expo) - density[ii:" << ii << "]: " << r_dist );
    get_max_index(r_dist, i, max, i_max_density);
    CRAWL("******************************************************************max(ii:" << i << ") = " << max);

    density[i] = r_dist;
  }
  size_t index = get_random_index(i_max_density);
  return index;
}

size_t MultiPolicy::get_max_index_by_euclidian_distance(const std::vector<Action> &policies_aa, LargeVector mean) const
{
  double max = 0;
  // size_t i_max = 0;
  std::vector<size_t> i_max_density;
  for(size_t i = 0; i < policies_aa.size(); ++i)
  {
    double dist = sum(pow(policies_aa[i].v - mean, 2));
    CRAWL("MultiPolicy::get_max_index_by_euclidian_distance:dist: " << dist);
    get_max_index(dist, i, max, i_max_density);
  }

  size_t index = get_random_index(i_max_density);

  return index;
}

LargeVector MultiPolicy::get_mean(const std::vector<Action> &policies_aa) const
{
  LargeVector mean;
  bool first = true;
  for(size_t i = 0; i < policies_aa.size(); ++i)
  {
    if(first)
      mean = policies_aa[i].v;
    else
      mean = mean + policies_aa[i].v;
    first = false;
  }
  return (mean / policies_aa.size());
}

void MultiPolicy::get_min_index(double dist, size_t i, double &min, std::vector<size_t> &i_min_density) const
{
  if (dist < min)
  {
    min = dist;
    i_min_density.clear();
    i_min_density.push_back(i);
    CRAWL("MultiPolicy::get_min_index:min: " << min << " i_min: " << i);
  } else if (dist == min)
    i_min_density.push_back(i);
}

LargeVector MultiPolicy::get_policy_mean(const Observation &in, std::vector<Action> &policies_aa, LargeVector &values) const
{
  size_t i = 0;
  bool first = true;
  Vector dummy;
  LargeVector mean;
  values = LargeVector::Zero(policies_aa.size());
  Vector send_actions(policies_aa.size());
  CRAWL("MultiPolicy::get_policy_mean:policies_aa.size(): " << policies_aa.size());
  for(std::vector<Action>::iterator it = policies_aa.begin(); it != policies_aa.end(); ++it, ++i)
  {
    policy_[i]->act(in, &*it);
    values[i] = value_[i]->read(in, &dummy);
    if (first)
      mean = it->v;
    else
      mean = mean + it->v;
    first = false;
    send_actions[i] = it->v[0];
    CRAWL("MultiPolicy::get_policy_mean:policy_[i:" << i << "][0]:" << it->v[0] << ", values[i:" << i << "]" << values[i]);
  }

  action_->set(send_actions);
  return (mean / policies_aa.size());
}

size_t MultiPolicy::get_random_index(const std::vector<size_t> &i_max_density) const
{
  int aleatorio = rand();
  size_t index = i_max_density.at(aleatorio%i_max_density.size());
  CRAWL("MultiPolicy::get_random_index::i_max_density.size(): " << i_max_density.size() << " aleatorio: " << aleatorio << " index: " << index);

  return index;
}

void MultiPolicy::update_mean_mov(const std::vector<double> &in) const
{
  CRAWL("MultiPolicy::update_mean_mov::for i < in.size()");  
  for(size_t i = 0; i < in.size(); ++i)
  {
    CRAWL("MultiPolicy::update_mean_mov::in(i= " << i << "): " << in[i] << ", mean_mov_->at(i): " << mean_mov_->at(i));
    mean_mov_->at(i) = (alpha_mov_mean_)*in[i] + (1-alpha_mov_mean_)*mean_mov_->at(i);
    CRAWL("MultiPolicy::update_mean_mov::in(i= " << i << "): " << in[i] << ", mean_mov_->at(i): " << mean_mov_->at(i));
  }
  CRAWL("MultiPolicy::update_mean_mov::ending...");
}

void MultiPolicy::update_mean_mov_with_euclidian(const std::vector<Action> &in, LargeVector mean) const
{
  double euclidian_dist = 0;
  for(size_t i = 0; i < in.size(); ++i)
  {
    CRAWL("MultiPolicy::update_mean_mov_with_euclidian::a(ii= " << i << "): " << in[i].v << ", mean_mov_->at(i): " << mean_mov_->at(i));
    euclidian_dist = sum(pow((in[i]).v - mean, 2));
    mean_mov_->at(i) = (alpha_mov_mean_)*euclidian_dist + (1-alpha_mov_mean_)*mean_mov_->at(i);
    CRAWL("MultiPolicy::update_mean_mov_with_euclidian::a(ii= " << i << "): "<<in[i].v<<" euclidian distance:dist: " << euclidian_dist << ", mean_mov_->at(i): " << mean_mov_->at(i));
  }
}

void MultiPolicy::update_voting_preferences_ofchoosen_mean_mov(const std::vector<Action> &in, size_t ind) const
{
  //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
  //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
  //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
  CRAWL("MultiPolicy::csRoulette::updating voting_policies_::ind: " << ind);
  for(size_t i = 0; i < voting_policies_->size(); ++i)
  {
    CRAWL("MultiPolicy::csRoulette::before::voting_policies_(i:" << i << "): " << voting_policies_->at(i));
    if ((i != ind) && (voting_policies_->at(i) > 0.65))
    {
      voting_policies_->at(ind) = voting_policies_->at(ind) + iRoulette_;
      voting_policies_->at(i) = voting_policies_->at(i) - iRoulette_;
    }
    CRAWL("MultiPolicy::csRoulette::after for::voting_policies_(i:" << i << "): " << voting_policies_->at(i));
  }

  for(size_t i = 0; i < in.size(); ++i)
  {
    CRAWL("MultiPolicy::update_voting_preferences_ofchoosen_mean_mov::a(ii= " << i << "): " << in[i].v << ", mean_mov_->at(i): " << mean_mov_->at(i));
    mean_mov_->at(i) = (alpha_mov_mean_)*voting_policies_->at(i) + (1-alpha_mov_mean_)*mean_mov_->at(i);
    CRAWL("MultiPolicy::update_voting_preferences_ofchoosen_mean_mov::a(ii= " << i << "): "<<in[i].v<<" voting_policies_->at(i): " << voting_policies_->at(i) << ", mean_mov_->at(i): " << mean_mov_->at(i));
  }
  //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
  //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
  //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
}
