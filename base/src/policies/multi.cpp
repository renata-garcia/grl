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
  "alg4stepsNew",
  "random",
  "static",
  "value_based",
  "roulette"}));
  
  config->push_back(CRP("ensemble_center", "Ensemble Center", ensemble_center_str_, CRP::Configuration,
  {"none", "density","data_center","mean"}));
  
  config->push_back(CRP("update_history", "Update History", update_history_str_, CRP::Configuration,
  {"none", "euclidian_distance", "density", "density_linear_order", "data_center_linear_order"}));
  
  config->push_back(CRP("percentile", "Percentile of Scores / Actions", percentile_));
  
  config->push_back(CRP("select_by_distance", "Select by distance", select_by_distance_str_, CRP::Configuration,
  {"none", "best", "best_elitism005", "best_elitism0001", "best_persistent", "best_delay_persistent", "best_d_persistent", "best_dc_persistent", "data_center", "density", "mean", "random", "random_persistent"}));
  
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
  else if (strategy_str_ == "alg4stepsNew")
    strategy_ = csAlg4StepsNew;
  else if (strategy_str_ == "static")
    strategy_ = csStatic;
  else if (strategy_str_ == "value_based")
    strategy_ = csValueBased;
  else if (strategy_str_ == "roulette")
    strategy_ = csRoulette;
  else
    throw bad_param("mapping/policy/multi:strategy");

  ensemble_center_str_ = config["ensemble_center"].str();
  if (ensemble_center_str_ == "density")
    ensemble_center_ = sdDensityBased;
  else if(ensemble_center_str_ == "data_center")
    ensemble_center_ = sdDataCenter;
  else if(ensemble_center_str_ == "mean")
    ensemble_center_ = sdMean;
  else if(ensemble_center_str_ == "none")
    ensemble_center_ = sdNone;

  update_history_str_ = config["update_history"].str();
  if (update_history_str_ == "none")
  {
    update_history_ = uhNone;
    scores_ = uhNone;
  }
  else if (update_history_str_ == "euclidian_distance")
  {
    update_history_ = uhEuclideanDistance;
    scores_ = uhEuclideanDistance;
  }
  else if (update_history_str_ == "density")
  {
    update_history_ = uhDensity;  
    scores_ = uhDensity;  
  }
  else if (update_history_str_ == "density_linear_order")
  {
    update_history_ = uhDensityLinear;
    scores_ = uhDensityLinear;
  }
  else if (update_history_str_ == "data_center_linear_order")
  {
    update_history_ = uhDataCenter;
    scores_ = uhDataCenter;
  }

  select_by_distance_str_ = config["select_by_distance"].str();
  if(select_by_distance_str_ == "none")
  {
    select_by_distance_ = sdNone;
    select_ = sdNone;
  }
  else if(select_by_distance_str_ == "best")
  {
    select_by_distance_ = sdBest;
    select_ = sdBest;
  }
  else if(select_by_distance_str_ == "best_elitism005")
  {
    select_by_distance_ = sdBestElitism005;
    select_ = sdBestElitism005;
  }
  else if(select_by_distance_str_ == "best_elitism0001")
  {
    select_by_distance_ = sdBestElitism0001;
    select_ = sdBestElitism0001;
  }
  else if(select_by_distance_str_ == "best_persistent")
  {
    select_by_distance_ = sdBestPersistent;
    select_ = sdBestPersistent;
  }
  else if(select_by_distance_str_ == "best_delay_persistent")
  {
    select_by_distance_ = sdBestDelayPersistent;
    select_ = sdBestDelayPersistent;
  }
  else if(select_by_distance_str_ == "best_dc_persistent")
  {
    select_by_distance_ = sdBestDCPersistent;
    select_ = sdBestDCPersistent;
  }
  else if(select_by_distance_str_ == "best_d_persistent")
  {
    select_by_distance_ = sdBestDPersistent;
    select_ = sdBestDPersistent;
  }
  else if(select_by_distance_str_ == "data_center")
  {
    select_by_distance_ = sdDataCenter;
    select_ = sdDataCenter;
  }
  else if(select_by_distance_str_ == "density")
  {
    select_by_distance_ = sdDensityBased;
    select_ = sdDensityBased;
  }
  else if(select_by_distance_str_ == "mean")
  {
    select_by_distance_ = sdMean;
    select_ = sdMean;
  }
  else if(select_by_distance_str_ == "random")
  {
    select_by_distance_ = sdRandom;
    select_ = sdRandom;
  }
  else if(select_by_distance_str_ == "random_persistent")
  {
    select_by_distance_ = sdRandomPersistent;
    select_ = sdRandomPersistent;
  }

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
  
  moving_average_ = ConstantLargeVector(policy_.size(), 0.);

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

  iterations_ = 0.;
  //---------------------------------
  percentile_ = config["percentile"];
  policy_persistent_ = 0;
}

void MultiPolicy::reconfigure(const Configuration &config)
{
}

void MultiPolicy::act(double time, const Observation &in, Action *out)
{
  if (!time) {
    iterations_++;
    CRAWL("MultiPolicy::act::sdBestDelayPersistent::in::pt_iterations_: " << iterations_);
  }
  Action tmp_action;
  LargeVector dist;
  int n_policies = policy_.size();
  std::vector<Action> actions_actors(n_policies);
  std::vector<node> action_actors(n_policies);
  std::vector<Action> aa_dist();
  policy_[0]->act(in, &actions_actors[0]);
  int n_dimension = actions_actors[0].v.size();
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
        
    case csAlg4StepsNew:
    {
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
      std::vector<size_t> ii_max_density;
      std::vector<Action> aa_normalized(n_policies);
      std::vector<double> density(n_policies);
      LargeVector scores;
      LargeVector center, vals;
      std::vector<double> score(0); 
      
      ActionArray aa_copied(n_policies);

      actions_actors = run_policies(in);

      if (scores_ != uhEuclideanDistance && ensemble_center_ != sdNone)
         throw Exception("ensemble_mean can only be used with update_history: eucludean_distance");
      else if (scores_ == uhEuclideanDistance && ensemble_center_ == sdNone)
        throw Exception("update_history: eucludean_distance requires a valid ensemble_mean");

      CRAWL("MultiPolicy::csAlg4StepsNew::switch (ensemble_center_)");
      switch (ensemble_center_)
      {
        case sdNone:
          CRAWL("MultiPolicy::csAlg4StepsNew::switch (ensemble_center_): sdNone");
          break;

        case sdDensityBased:
          density_based(actions_actors, &center);
          break;
      
        case sdDataCenter:
          data_center(actions_actors, &center);
          break;
      
        case sdMean:
          center = g_mean(actions_actors);
          break;

        default:
          throw Exception("MultiPolicy::csAlg4StepsNew::ensemble_center_ not implemented!");
      }

      CRAWL("MultiPolicy::csAlg4StepsNew::switch (scores_)");
      switch(scores_)
      {
        case uhNone:
          CRAWL("MultiPolicy::csAlg4StepsNew::switch (scores_): uhNone");
          scores =  ConstantLargeVector(actions_actors.size(), 0.);
         //TODO: como proibir uso do percentile ou percentile_x_alpha 
          // scores = get_actions(actions_actors);
          break;

        case uhEuclideanDistance:
          scores = euclidian_distance(actions_actors, center);
          break;
        
        case uhDensity:
          scores = density_based(actions_actors, &center);
          break;
        
        case uhDensityLinear:
          scores = density_based_update_voting(actions_actors, &center);
          break;

        case uhDataCenter:
          scores = datacenter_update_voting(actions_actors);
          break;

        default:
          throw Exception("MultiPolicy::csAlg4StepsNew::scores_ not implemented!");
      }

      for(size_t i = 0; i < policy_.size(); ++i)
        CRAWL("MultiPolicy::csAlg4StepsNew::scores[i= " << i << "]: " << scores[i]);

      CRAWL("MultiPolicy::moving_average_ = alpha_mov_mean_*scores + (1-alpha_mov_mean_)*moving_average_;");
      moving_average_ = alpha_mov_mean_*scores + (1-alpha_mov_mean_)*moving_average_;
      
      ActionArray active_set = percentile(select_by_distance_, time, actions_actors, moving_average_, percentile_);

      for(size_t i = 0; i < active_set.size(); ++i)
        CRAWL("MultiPolicy::csAlg4Steps::choosed active_set[i:" << i << "]: " << active_set[i].v[0]);

      switch (select_by_distance_)
      {
        case sdBest:
        dist = active_set[0].v;
          break;

        case sdBestElitism005:
        case sdBestElitism0001:
          dist = actions_actors[policy_persistent_].v;
          break;

        case sdBestPersistent:
          dist = actions_actors[policy_persistent_].v;
          break;

        case sdBestDelayPersistent:
          if (iterations_ < 100) {
            dist = active_set[(size_t)rand()%active_set.size()].v;
            CRAWL("MultiPolicy::csAlg4Steps::sdBestDelayPersistent::if (iterations_ < 100) { - iterations_: " << iterations_);
          } else {
            dist = actions_actors[policy_persistent_].v;
            CRAWL("MultiPolicy::csAlg4Steps::sdBestDelayPersistent::dist = active_set[policy_persistent_].v;");
          }
          break;

        case sdBestDCPersistent:
          if (iterations_ < 100) {
            data_center(active_set, &dist);
          } else {
            dist = actions_actors[policy_persistent_].v;
          }
          break;

        case sdBestDPersistent:
          if (iterations_ < 100) {
            density_based(active_set, &dist);
          } else {
            dist = actions_actors[policy_persistent_].v;
          }
          break;

        case sdDensityBased:
          density_based(active_set, &dist);
          break;
          
        case sdDataCenter:
          data_center(active_set, &dist);
          break;
          
        case sdMean:
          dist = g_mean(active_set);
          break;

        case sdRandom:
        {
          int aleatorio = rand();
          size_t policy_random = aleatorio%active_set.size();
          dist = active_set[policy_random].v;
          CRAWL("MultiPolicy::csAlg4Steps::case sdRandom active_set[policy_random: " << policy_random << "]->v: " << dist);
        }
        break;

        case sdRandomPersistent:
        {
          int aleatorio = rand();
          if (!time)
            policy_persistent_ = aleatorio%active_set.size();
          dist = active_set[policy_persistent_].v;
          CRAWL("MultiPolicy::csAlg4Steps::case sdRandom active_set[policy_random: " << policy_persistent_ << "]->v: " << dist);
        }
        break;
      }

      CRAWL("MultiPolicy::csAlg4Steps::dist: " << dist);
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
      //88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
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
      LargeVector values;
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

LargeVector MultiPolicy::get_policy_mean(const Observation &in, std::vector<node> *action_actors, LargeVector *values) const
{
  bool first = true;
  Vector dummy;
  LargeVector mean;
  *values = LargeVector::Zero(action_actors->size());
  Vector send_actions(action_actors->size());
  CRAWL("MultiPolicy::get_policy_mean:action_actors->size(): " << action_actors->size());
  //for(std::vector<node>::iterator it = action_actors.begin(); it != action_actors.end(); ++it, ++i)
  for(size_t i = 0; i < action_actors->size(); ++i)
  {
    Action tmp;
    policy_[i]->act(in, &tmp);
    // *values[i] = *value_[i]->read(in, &dummy);
    (action_actors->at(i)).action = tmp.v;
    // (action_actors->at(i)).action[0] = i;
    (action_actors->at(i)).normalized = -1 + 2*( ((action_actors->at(i)).action - min_) / (max_ - min_) );
    (action_actors->at(i)).score = 0;
    (action_actors->at(i)).id = i;
    if (first)
      mean = (action_actors->at(i)).action;
    else 
      mean = mean + (action_actors->at(i)).action;
    first = false;
    send_actions[i] = tmp.v[0];
    //CRAWL("MultiPolicy::get_policy_mean:policy_[i:" << i << "][0]:" << tmp.v[0] << ", values[i:" << i << "]" << values[i]);
    CRAWL("MultiPolicy::get_policy_mean:policy_[i:" << i << "][0]:" << (action_actors->at(i)).action[0]);
  }

  action_->set(send_actions);
  return (mean / action_actors->size());
}

//...............................................................................................................

LargeVector MultiPolicy::g_mean(const ActionArray &array) const
{
  CRAWL("MultiPolicy::g_mean");
  LargeVector mean = array[0].v;
  
  for(size_t i = 1; i < array.size(); ++i)
    mean = mean + array[i].v;
  
  return (mean / array.size());
}

LargeVector MultiPolicy::get_actions(const ActionArray &array) const
{
  //TODO: get all v[n_dimension]
  CRAWL("MultiPolicy::get_actions");
  LargeVector actions =  ConstantLargeVector(array.size(), 0.);
  
  for(size_t i = 0; i < array.size(); ++i)
    actions[i] = array[i].v[0];
  
  return actions;
}

MultiPolicy::ActionArray MultiPolicy::percentile(ScoreDistance mode, double time,  ActionArray const &array, LargeVector moving_average_, double percentile)
{
  CRAWL("MultiPolicy::percentile");
  ActionArray retorno;
  double sum_ma = 0;
  std::vector<std::tuple<double, size_t, double>> tuple_mean_id(array.size());

  for(size_t i = 0; i < array.size(); ++i)
    sum_ma += -1*moving_average_[i];

  for(size_t i = 0; i < array.size(); ++i)
    tuple_mean_id[i] = std::tuple<double, size_t, double>(-1*moving_average_[i], i, (-1*moving_average_[i])/sum_ma);

  std::sort(tuple_mean_id.begin(), tuple_mean_id.end());
  int ind_cut = std::max(1, (int) (tuple_mean_id.size() * percentile));

  for (size_t i = 0; i < tuple_mean_id.size(); ++i)
    CRAWL("MultiPolicy::percentile::ind_cut= " << ind_cut << "get<0>(tuple_mean_id[i:" << i << "])" << std::get<0>(tuple_mean_id[i]) << ", get<1>(tuple_mean_id[i:" << i << "])" << std::get<1>(tuple_mean_id[i]) << ", get<2>(tuple_mean_id[i:" << i << "])" << std::get<2>(tuple_mean_id[i]) << ".");

  for(size_t k = 0; k < ind_cut; ++k)
  {
    CRAWL("MultiPolicy::percentile::get<0>(tuple_mean_id[k:" << k << "])" << std::get<0>(tuple_mean_id[k]) << ", get<1>(tuple_mean_id[k:" << k << "])" << std::get<1>(tuple_mean_id[k]) << ", get<2>(tuple_mean_id[k:" << k << "])" << std::get<2>(tuple_mean_id[k]) << ".");
    size_t j = std::get<1>(tuple_mean_id[k]);
    retorno.push_back( array[j] );
  }

  if (mode == sdBestElitism005) {
    if ((std::get<2>(tuple_mean_id[1]) - std::get<2>(tuple_mean_id[0])) > 0.005)
      policy_persistent_ = std::get<1>(tuple_mean_id[0]);
    // INFO("MultiPolicy::percentile::if (mode == sdBestElitism)" << "p: " << policy_persistent_ << ".. diff = " << (std::get<2>(tuple_mean_id[1]) - std::get<2>(tuple_mean_id[0])) );
  } else if (mode == sdBestElitism0001) {
    if ((std::get<2>(tuple_mean_id[1]) - std::get<2>(tuple_mean_id[0])) > 0.0001)
      policy_persistent_ = std::get<1>(tuple_mean_id[0]);
    // INFO("MultiPolicy::percentile::if (mode == sdBestElitism)" << "p: " << policy_persistent_ << ".. diff = " << (std::get<2>(tuple_mean_id[1]) - std::get<2>(tuple_mean_id[0])) );
  } else if ((mode == sdBestPersistent) || (mode == sdBestDelayPersistent) || (mode  == sdBestDCPersistent) || (mode  == sdBestDPersistent)) {
    if (!time)
      policy_persistent_ = std::get<1>(tuple_mean_id[0]);
    CRAWL("MultiPolicy::percentile::if ((mode == sdBestPersistent) || (mode  == sdBestDCPersistent)");
  }

  CRAWL("MultiPolicy::percentile::retorno.size(): " << retorno.size());
  return retorno;
}

LargeVector MultiPolicy::density_based(ActionArray &ensemble_set, LargeVector *center) const
{
  LargeVector scores =  ConstantLargeVector(ensemble_set.size(), 0.);
  int n_dimension = ensemble_set[0].v.size();
  CRAWL("MultiPolicy::density_based::n_dimension: " << n_dimension);

  // for(size_t i = 0; i < ensemble_set.size(); ++i)
  //   ensemble_set[i].v[0] = i*0.36;
    
  // for(size_t i = 0; i < ensemble_set.size(); ++i)
  //   CRAWL("MultiPolicy::density_based::RESET::ensemble_set[i:" << i << "].v[0]: " << ensemble_set[i].v[0]);
  
  for(size_t i = 0; i < ensemble_set.size(); ++i)
  {
    std::string strtmp = "";
    std::string strspace = "                    ";
    double r_dist = 0.0;
    LargeVector i_normalized = -1 + 2*((ensemble_set[i].v - min_)/(max_ - min_));
    for(size_t j = 0; j < ensemble_set.size(); ++j)
    {
      double expoent = 0.0;
      LargeVector j_normalized = -1 + 2*((ensemble_set[j].v - min_)/(max_ - min_));
      for(size_t k = 0; k != n_dimension; ++k)
      {
        expoent += pow(i_normalized[k] - j_normalized[k], 2);
        // strtmp += strspace + "expoent(k:" + std::to_string(k) + "): " +  std::to_string(expoent) + " (1): " + std::to_string(i_normalized[k]) + " (2): " + std::to_string(j_normalized[k]) + "\n";
      }
      // strtmp += strspace + strspace + "r_dist(before): " + std::to_string(r_dist) + " expoent: " + std::to_string((-1 * expoent / pow(r_distance_parameter_, 2))) + " exp: " + std::to_string(exp( -1 * expoent / pow(r_distance_parameter_, 2))) + "\n";
      r_dist = r_dist + exp( -1 * expoent / pow(r_distance_parameter_, 2) );
    }
    // CRAWL(strtmp << strspace << "sum(expo) - density[i:" << i << "]: " << r_dist );

    CRAWL("MultiPolicy::density_based::density*[i:" << i << "]: " << r_dist );
    scores[i] = r_dist;
  }
  
  *center = ensemble_set[get_max_index(scores)].v;
  CRAWL("MultiPolicy::density_based::*center[0]: " << (*center)[0]);

  return scores;
}

LargeVector MultiPolicy::data_center(ActionArray ensemble_set, LargeVector *center) const
{
  CRAWL("MultiPolicy::data_center");
  LargeVector mean = g_mean(ensemble_set);
  while(ensemble_set.size() > 2)
  { 
    LargeVector euclidian_distance = ConstantLargeVector(ensemble_set.size(), 0.);
    // LargeVector euclidian_distance = euclidian_distance(ensemble_set);/*, mean*/
    for(size_t i = 0; i < ensemble_set.size(); ++i)
      euclidian_distance[i] = sum(pow(ensemble_set[i].v - mean, 2));

    size_t index = get_max_index(euclidian_distance);
    CRAWL("MultiPolicy::data_center::remove outlier");
    
    ensemble_set.erase(ensemble_set.begin()+index);

    for(size_t i=0; i < ensemble_set.size(); ++i)
      CRAWL("MultiPolicy::data_center::after remove the i_max actions_actors: " << ensemble_set[i].v);
    
    CRAWL("MultiPolicy::data_center::starting new mean");
    mean = g_mean(ensemble_set);
    CRAWL("MultiPolicy::data_center::mean...........: " << mean);
  }

  *center = mean;
  return mean;
}

LargeVector MultiPolicy::euclidian_distance(const ActionArray &ensemble_set, const LargeVector center) const
{
  if (ensemble_set.size() < 2)
    throw Exception("MultiPolicy::euclidian_distance::ensemble_set.size() < 2");

  LargeVector euclidian_distance = ConstantLargeVector(policy_.size(), 0.);
  for(size_t i = 0; i < ensemble_set.size(); ++i)
  {
     euclidian_distance[i] = -sum(pow(ensemble_set[i].v - center, 2));
    CRAWL("MultiPolicy::euclidian_distance[i: " << i << " ]: " << euclidian_distance[i]);
  }
  return euclidian_distance;
}

size_t MultiPolicy::get_max_index(const LargeVector &in) const
{
  double max = -std::numeric_limits<double>::infinity();
  std::vector<size_t> i_max_density;
  for(size_t i = 0; i < in.size(); ++i)
  {
    double dist = in[i];
    if (dist > max)
    {
      max = dist;
      i_max_density.clear();
      i_max_density.push_back(i);
      CRAWL("MultiPolicy::get_max_index:max: " << max << " i_max: " << i);
    } else if (dist == max)
      i_max_density.push_back(i);
  }

  int aleatorio = rand();
  size_t index = i_max_density.at(aleatorio%i_max_density.size());
  CRAWL("MultiPolicy::get_max_index::i_max_density.size(): " << i_max_density.size() << " aleatorio: " << aleatorio << " index: " << index);

  return index;
}

MultiPolicy::ActionArray MultiPolicy::run_policies(const Observation &in, LargeVector *values) const
{
  ActionArray actions(0);
  Vector dummy;
  // if (values != NULL)
  //   values = LargeVector::Zero(policy_.size());
  Vector send_actions(policy_.size());
  CRAWL("MultiPolicy::run_policies:policy_.size(): " << policy_.size());
  for(size_t i = 0; i < policy_.size(); ++i)
  {
    Action tmp;
    policy_[i]->act(in, &tmp);
    actions.push_back(tmp);
    if (values != NULL)
      values[i] = value_[i]->read(in, &dummy);
    send_actions[i] = tmp.v[0];
    CRAWL("MultiPolicy::run_policies:policy_[i:" << i << "][0]:" << tmp.v[0]);
    if(values != NULL)
      CRAWL("MultiPolicy::run_policies: values[i:" << i << "]" << values[i]);
  }

  action_->set(send_actions);
  return actions;
}

LargeVector MultiPolicy::datacenter_update_voting(ActionArray ensemble_set) const
{
  CRAWL("MultiPolicy::datacenter_update_voting:: initing variables");
  //TODO: retirar o voting_weights_id
  size_t ensemble_set_size = ensemble_set.size();
  LargeVector voting_weights = ConstantLargeVector(ensemble_set_size, 0.);
  LargeVector voting_weights_id_kepper = ConstantLargeVector(ensemble_set_size, 0.);

  for(size_t i=0; i < voting_weights.size(); ++i)
  {
    voting_weights[i] = 1 + iRoulette_*(ensemble_set_size-1);
    voting_weights_id_kepper[i] = i;
  }

  while(ensemble_set.size() > 2)
  {
    // size_t index = get_max_index_by_euclidian_distance(actions_actors, mean);
    //TODO: error: no match for call to ‘(grl::LargeVector {aka Eigen::Array<double, 1, -1>}) (grl::MultiPolicy::ActionArray&, grl::LargeVector)’
    //TODO: LargeVector euclidian_distance = euclidian_distance(ensemble_set, g_mean(ensemble_set));

    LargeVector mean = g_mean(ensemble_set);
    LargeVector euclidian_distance = ConstantLargeVector(ensemble_set.size(), 0.);
    for(size_t i = 0; i < ensemble_set.size(); ++i)
      euclidian_distance[i] = sum(pow(ensemble_set[i].v - mean, 2));

    size_t index = get_max_index(euclidian_distance);

    CRAWL("MultiPolicy::datacenter_update_voting::remove outlier");
    ensemble_set.erase(ensemble_set.begin()+index);

    for(size_t i=0; i < ensemble_set.size(); ++i)
      CRAWL("MultiPolicy::datacenter_update_voting::after remove the i_max actions_actors: " << ensemble_set[i].v);

    //atualizando o vetor de voting_weights conforme escolha de retirada
    bool found = false;
    for(size_t i = 0; i < ensemble_set_size; ++i)
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

    CRAWL("MultiPolicy::datacenter_update_voting::starting new mean");
    mean = g_mean(ensemble_set);
    CRAWL("MultiPolicy::datacenter_update_voting::mean...........: " << mean);
  }

  return voting_weights;
}

LargeVector MultiPolicy::density_based_update_voting(ActionArray &ensemble_set, LargeVector *center) const
{
  LargeVector scores =  density_based(ensemble_set, center);
  LargeVector voting_weights = ConstantLargeVector(scores.size(), 0.);

  std::vector<std::tuple<double, size_t>> tuple_density_id(scores.size());
  
  for(size_t i = 0; i < scores.size(); ++i)
    tuple_density_id[i] = std::tuple<double, size_t>(scores(i), i);
  
  std::sort(tuple_density_id.begin(), tuple_density_id.end());

  for (size_t i = 0; i < tuple_density_id.size(); i++)
  {
    CRAWL("MultiPolicy::density_based_update_voting::tuple_density_id<id> = " << 1*std::get<1>(tuple_density_id[i]) );
    CRAWL(" tuple_density_id<score> = " << std::get<0>(tuple_density_id[i]) );
  }

  for (size_t i = 0; i < tuple_density_id.size(); i++)
  {
    size_t j = std::get<1>(tuple_density_id[i]); 
    tuple_density_id[i] = std::tuple<double, size_t>(1 + iRoulette_*(i), j);;
  }

  for(int i =0; i < scores.size(); ++i)
    voting_weights[std::get<1>(tuple_density_id[i])] = std::get<0>(tuple_density_id[i]);
  
  for(int i =0; i < scores.size(); ++i)
    CRAWL("MultiPolicy::density_based_update_voting::voting_weights<i=" << i << "> = " << voting_weights[i] );
  
  return voting_weights;
}

