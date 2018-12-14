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
  config->push_back(CRP("strategy", "Combination strategy", strategy_str_, CRP::Configuration, {"binning", "density_based", "density_based_mean_mov", "data_center", "data_center_mean_mov", "mean", "mean_mov", "random", "static", "value_based", "roulette"}));
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
  else if (strategy_str_ == "data_center")
    strategy_ = csDataCenter;
  else if (strategy_str_ == "data_center_mean_mov")
    strategy_ = csDataCenterMeanMov;
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
  if (strategy_str_ == "roulette")
  {
    for(size_t i = 0; i < voting_policies_->size(); ++i)
    {
      voting_policies_->at(i) = 1;
    }
  }

  action_ = new VectorSignal();  
  config.set("actions", action_);

  *pt_iterations_ = 0;
}

void MultiPolicy::reconfigure(const Configuration &config)
{
}

void MultiPolicy::act(const Observation &in, Action *out) const
{
  *pt_iterations_ = *pt_iterations_ + 1;
  CRAWL("MultiPolicy::act::in::pt_iterations_: " << *pt_iterations_);
  Action tmp_action;
  LargeVector dist;
  int n_policies = policy_.size();
  std::vector<Action> actions_actors(n_policies);
  std::vector<Action> aa_dist();
  policy_[0]->act(in, &actions_actors[0]);
  int n_dimension = actions_actors[0].v.size();
  // if(*pt_iterations_ == 1)
  //   last_action_ = LargeVector::Zero(n_dimension);
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
      std::vector<double> density(n_policies);
      LargeVector mean, vals;
      
      mean = get_policy_mean(in, actions_actors, vals);
      
      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++it_norm)
        (*it_norm).v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );

      for(size_t i = 0; i < aa_normalized.size(); ++i)
        CRAWL("MultiPolicy::csDensityBased::aa_normalized: " << aa_normalized[i]);

      size_t index = get_max_index_by_density_based(aa_normalized, mean);

      dist = actions_actors[index].v;
    }
    break;
        
    case csDensityBasedMeanMov:
    {
      std::vector<size_t> ii_max_density;
      std::vector<Action> aa_normalized(n_policies);
      std::vector<double> density(n_policies);
      LargeVector mean, vals;
      
      mean = get_policy_mean(in, actions_actors, vals);

      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++it_norm)
        (*it_norm).v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );

      euclidian_distance_moving_mean(actions_actors, mean);
      // euclidian_distance_moving_mean(actions_actors, last_action_);
      std::vector<size_t> v_id = moving_mean(actions_actors);
      for(size_t i = 0; i < actions_actors.size(); ++i)
        CRAWL("MultiPolicy::csDensityBasedMeanMov::actions_actors after euclidian_distance_moving_mean: " << actions_actors[i]);

      for(size_t i=0; i < v_id.size(); ++i)
        aa_normalized.erase(aa_normalized.begin()+v_id[i]-i);
      CRAWL("MultiPolicy::csDensityBasedMeanMov::removed ");
      for(std::vector<Action>::iterator it = aa_normalized.begin(); it!=aa_normalized.end(); ++it)
        CRAWL("MultiPolicy::csDensityBasedMeanMov::aa_normalized<after remove>:: " << it->v[0]);

      size_t index = get_max_index_by_density_based(aa_normalized, mean);

      // last_action_ = actions_actors[index].v;
      dist = actions_actors[index].v;
    }
    break;
        
    case csDataCenter:
    {
      CRAWL("MultiPolicy::csDataCenter::starting********************************************************************************");      
      LargeVector mean, vals;

      mean = get_policy_mean(in, actions_actors, vals);
      CRAWL("MultiPolicy::csDataCenter::collecting mean: " << mean);
      
      while(actions_actors.size() > bins_)
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
        
    case csDataCenterMeanMov:
    {
      CRAWL("MultiPolicy::csDataCenterMeanMov::starting********************************************************************************");      
      std::vector<double>::iterator itd;     
      LargeVector mean, vals;

      mean = get_policy_mean(in, actions_actors, vals);
      CRAWL("MultiPolicy::csDataCenterMeanMov::collecting mean: " << mean);

      euclidian_distance_moving_mean(actions_actors, mean);
      moving_mean(actions_actors);
      for(size_t i = 0; i < actions_actors.size(); ++i)
        CRAWL("MultiPolicy::actions_actors after euclidian_distance_moving_mean: " << actions_actors[i]);
      
      while(actions_actors.size() > bins_)
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
        
    case csMean:
    { 
      LargeVector vals;
      dist = get_policy_mean(in, actions_actors, vals);
    }
    break;

    case csMeanMov:
    {
      LargeVector vals;
      euclidian_distance_moving_mean(actions_actors, get_policy_mean(in, actions_actors, vals));
      moving_mean(actions_actors);
      
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
      double roulette = rand() * n_policies;

      std::random_device rd;  //Will be used to obtain a seed for the random number engine
      std::mt19937 gen(rd()); //Standard mersenne_twister_engine seeded with rd()
      std::uniform_int_distribution<> dis(0, n_policies-1);
      
      get_policy_mean(in, actions_actors, values);

      size_t ind = 0;
      for(size_t i = 0; i < voting_policies_->size(); ++i)
      {
        CRAWL( "MultiPolicy::csRoulette::rouling::roulette: " << roulette << ", voting_policies_->at(i:" << i << "): " << voting_policies_->at(i) );
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

void MultiPolicy::euclidian_distance_moving_mean(const std::vector<Action> &in, LargeVector mean) const
{
  double euclidian_dist = 0;
  for(size_t i = 0; i < in.size(); ++i)
  {
    CRAWL("MultiPolicy::euclidian_distance_moving_mean::a(ii= " << i << "): " << in[i].v << ", mean_mov_->at(i): " << mean_mov_->at(i));
    euclidian_dist = sum(pow((in[i]).v - mean, 2));
    mean_mov_->at(i) = (alpha_mov_mean_)*euclidian_dist + (1-alpha_mov_mean_)*mean_mov_->at(i);
    CRAWL("MultiPolicy::euclidian_distance_moving_mean::a(ii= " << i << "): "<<in[i].v<<" euclidian distance:dist: " << euclidian_dist << ", mean_mov_->at(i): " << mean_mov_->at(i));
  }
}

void MultiPolicy::voting_moving_mean(const std::vector<Action> &in) const
{
  double voting = 0;
  for(size_t i = 0; i < in.size(); ++i)
  {
    CRAWL("MultiPolicy::voting_moving_mean::a(ii= " << i << "): " << in[i].v << ", mean_mov_->at(i): " << mean_mov_->at(i));
    // voting_moving_mean = sum(pow((in[i]).v - mean, 2));
    mean_mov_->at(i) = (alpha_mov_mean_)*voting_moving_mean + (1-alpha_mov_mean_)*mean_mov_->at(i);
    CRAWL("MultiPolicy::voting_moving_mean::a(ii= " << i << "): "<<in[i].v<<" euclidian distance:dist: " << euclidian_dist << ", mean_mov_->at(i): " << mean_mov_->at(i));
  }
}

size_t MultiPolicy::get_max_index_by_density_based(const std::vector<Action> &policies_aa, LargeVector mean) const
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

size_t MultiPolicy::get_random_index(const std::vector<size_t> &i_max_density) const
{
  int aleatorio = rand();
  size_t index = i_max_density.at(aleatorio%i_max_density.size());
  CRAWL("MultiPolicy::get_random_index::i_max_density.size(): " << i_max_density.size() << " aleatorio: " << aleatorio << " index: " << index);

  return index;
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

LargeVector MultiPolicy::get_policy_mean(const Observation &in, std::vector<Action> &policies_aa, LargeVector &values) const
{
  //8888888888888888888888888888888888888888888888888888888888888888888888888888888888
  //8888888888888888888888888888888888888888888888888888888888888888888888888888888888
  //8888888888888888888888888888888888888888888888888888888888888888888888888888888888
  size_t i = 0;
  bool first = true;
  // LargeVector tmp;
  // bool equalsPolicy = true;
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
    {
      mean = it->v;
      // tmp = it->v[0];
    }
    else
    {
      mean = mean + it->v;
      // if (sum(tmp - it->v[0]) > 1E-6) 
      //   equalsPolicy = false;
    }
    first = false;
    send_actions[i] = it->v[0];
    CRAWL("MultiPolicy::get_policy_mean:policy_[i:" << i << "][0]:" << it->v[0] << ", values[i:" << i << "]" << values[i]);
  }
  // if(equalsPolicy)
  //   std::cout << "MultiPolicy::Equals Policy::policy: " << tmp << std::endl;
  //8888888888888888888888888888888888888888888888888888888888888888888888888888888888
  //8888888888888888888888888888888888888888888888888888888888888888888888888888888888
  //8888888888888888888888888888888888888888888888888888888888888888888888888888888888

  action_->set(send_actions);
  return (mean / policies_aa.size());
}

std::vector<size_t> MultiPolicy::moving_mean(std::vector<Action> &in) const
{
  CRAWL("MultiPolicy:: " << in);
  double bound_quantile[] = {minor_remove_bound_, major_remove_bound_};

  std::vector<double> quantile(0);
  for (std::vector<double>::iterator it=mean_mov_->begin(); it!=mean_mov_->end(); ++it)
    quantile.push_back(*it);

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
    //if ( (*itd < fst) || (*itd > trd))
    if ( (fst - *itd > 1E-6) || (*itd - trd > 1E-6) )
      v_id.push_back(i);

  for(size_t i=0; i < v_id.size(); ++i)
    in.erase(in.begin()+v_id[i]-i);
    
  CRAWL("MultiPolicy::moving_mean::in.size(): " << in.size() << ", v_id(): " << v_id.size());

  return v_id;
}
