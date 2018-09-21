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

REGISTER_CONFIGURABLE(DiscreteMultiPolicy)

REGISTER_CONFIGURABLE(MultiPolicy)

void MultiPolicy::request(ConfigurationRequest *config)
{
  config->push_back(CRP("strategy", "Combination strategy", strategy_str_, CRP::Configuration, {"policy_strategy_binning", "policy_strategy_density_based", "policy_strategy_data_center", "policy_strategy_mean"}));
  config->push_back(CRP("policy", "mapping/policy", "Sub-policies", &policy_));
  config->push_back(CRP("value", "mapping", "Values of sub-policy actions", &value_));

  config->push_back(CRP("bins", "Binning Simple Discretization", bins_));
  config->push_back(CRP("r_distance_parameter", "R Distance Parameter", r_distance_parameter_));
  
  config->push_back(CRP("output_min", "vector.action_min", "Lower limit on outputs", min_, CRP::System));
  config->push_back(CRP("output_max", "vector.action_max", "Upper limit on outputs", max_, CRP::System));

  config->push_back(CRP("actions", "signal/vector.action", "Suggested actions", CRP::Provided));
}

void MultiPolicy::configure(Configuration &config)
{
  strategy_str_ = config["strategy"].str();
  if (strategy_str_ == "policy_strategy_binning")
    strategy_ = csBinning;
  else if (strategy_str_ == "policy_strategy_density_based")
    strategy_ = csDensityBased;
  else if (strategy_str_ == "policy_strategy_data_center")
    strategy_ = csDataCenter;
  else if (strategy_str_ == "policy_strategy_mean")
    strategy_ = csMean;
  else
    throw bad_param("mapping/policy/multi:strategy");

  bins_ = config["bins"];
  r_distance_parameter_ = config["r_distance_parameter"];

  min_ = config["output_min"].v();
  max_ = config["output_max"].v();

  if (min_.size() != max_.size() || !min_.size())
    throw bad_param("policy/action:{output_min,output_max}");

  policy_ = *(ConfigurableList*)config["policy"].ptr();
  value_ = *(ConfigurableList*)config["value"].ptr();
  
  if (policy_.empty())
    throw bad_param("mapping/policy/multi:policy is empty");
  
  action_ = new VectorSignal();
  
  config.set("actions", action_);
}

void MultiPolicy::reconfigure(const Configuration &config)
{
}

void MultiPolicy::act(const Observation &in, Action *out) const
{
  LargeVector dist;
  Action tmp_action;
  std::vector<Action> actions_actors(policy_.size());
  policy_[0]->act(in, &actions_actors[0]);
  int n_dimension = actions_actors[0].v.size();
  int n_policies = policy_.size();
  double* result = new double[n_dimension];
  
  Vector dummy;
  double q = value_[0]->read(in, &dummy);

  switch (strategy_)
  {
    case csBinning:
    {
      double* actions_actors = new double[policy_.size()];
      
      CRAWL("MultiPolicy::csBinning histogram");

      double* histogram = new double[bins_];
      for (size_t ii=0; ii < bins_; ++ii)
          histogram[ii] = 0;

      double* result = new double[n_dimension];
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
        result[jj] = 0.0;
        for (size_t ii=0; ii < policy_.size(); ++ii)
        {
          i_bin = std::min((int)floor(bins_ * (actions_actors[ii] - min_[jj]) / (max_[jj] - min_[jj]) ), bins_-1);
          CRAWL("MultiPolicy::i_bin: " << i_bin << "\n");
          CRAWL("MultiPolicy::histogram[binmax]: " << histogram[binmax] << " - histogram[i_bin]: " << histogram[i_bin] << "\n");
          if ( histogram[binmax] == histogram[i_bin] )
          {
            result[jj] += actions_actors[ii];
            CRAWL("MultiPolicy::a[" << ii << "]: " << actions_actors[ii] << "\n");
            ++n_binmax;
          }
        }
        result[jj] = result[jj] / n_binmax;
        CRAWL("MultiPolicy::result: " << result[jj] << " n_binmax: " << n_binmax << "\n");
      }
      dist = ConstantLargeVector(n_dimension, *result);
    }
    break;
        
    case csDensityBased:
    {
      size_t ii_max = 0;
      std::string strspace = "";
      for(size_t kk=0; kk < 32; ++kk)
        strspace += " ";

      std::vector<Action> aa_normalized(n_policies);
      std::vector<double> density(n_policies);
      std::vector<size_t> ii_max_density;
      double exp_result = 0.0;
  
      size_t ii = 0;
      dist = LargeVector::Zero(n_policies);
      
      Vector send_actions(n_policies);
      
      Action tmp;
      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++ii)
      {
        policy_[ii]->act(in, &*it);
        tmp.v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );
        (*it_norm) = tmp;
        ++it_norm;
        CRAWL("ii: " << ii << " actions_actors: " << (*it).v << " normalized: " << tmp.v);

        send_actions[ii] = it->v[0];
      }

      action_->set(send_actions);

      double max = -1 * std::numeric_limits<double>::infinity();
      std::vector<Action>::iterator it, it2, i_max;
      ii = 0;
      for( it=aa_normalized.begin(); it != aa_normalized.end(); ++it, ++ii)
      {
        std::string strtmp = "";
        double r_dist = 0.0;
        for( it2=aa_normalized.begin(); it2 != aa_normalized.end(); ++it2)
        {
          double expoent = 0.0;
          for(size_t jj = 0; jj != n_dimension; ++jj)
          {
            expoent += pow((*it).v[jj] - (*it2).v[jj], 2);
            //strtmp += strspace + "expoent(jj:" + std::to_string(jj) + "): " +  std::to_string(expoent) + " (1): " + std::to_string((*it).v[jj]) + " (2): " + std::to_string((*it2).v[jj]) + "\n";
          }
          //strtmp += strspace + strspace + "r_dist(before): " + std::to_string(r_dist) + " expoent: " + std::to_string((-1 * expoent / pow(r_distance_parameter_, 2))) + " exp: " + std::to_string(exp( -1 * expoent / pow(r_distance_parameter_, 2))) + "\n";
          r_dist = r_dist + exp( -1 * expoent / pow(r_distance_parameter_, 2) );
        }
        density.push_back( r_dist );
        //CRAWL(strtmp << strspace << "sum(expo) - density[ii:" << ii << "]: " << r_dist );
        if (r_dist > max)
        {
          max = r_dist;
          //CRAWL("******************************************************************max(ii:"<<ii<<") = " << max );
          i_max = it;
          ii_max_density.clear();
          ii_max_density.push_back(ii);
          //ii_max = ii;
        } else if (r_dist == max)
        {
          //CRAWL("******************************************************************max(ii:"<<ii<<") = " << max );
          ii_max_density.push_back(ii);
        }
      }

      for (size_t jj=0; jj < n_dimension; ++jj)
      {
        int aleatorio = rand();
        size_t index = ii_max_density.at(aleatorio%ii_max_density.size());
        CRAWL( "MultiPolicy::ii_max_density.size(): " << ii_max_density.size() << " aleatorio: " << aleatorio << " index: " << index);
        result[jj] = actions_actors[index].v[jj];
        //CRAWL( "MultiPolicy::result_[ii_max=" << index << "][jj:" << jj << "]: " << result[jj] );
      }

      dist = ConstantLargeVector( n_dimension, *result );
    }
    break;
        
    case csDataCenter:
    {
      std::deque<Action> actions_actors2(policy_.size());
      LargeVector mean;
      bool first = true;
      size_t ii = 0;
      for(std::deque<Action>::iterator it = actions_actors2.begin(); it != actions_actors2.end(); ++it, ++ii)
      {
        policy_[ii]->act(in, &*it);
        if (first)
          mean = it->v;
        else
          mean = mean + it->v;
        first = false;
      }
      mean = mean / policy_.size();
      
      while(actions_actors2.size() > 2)
      {
        //PRINTLN
        //for (std::deque <Action> :: iterator it = actions_actors2.begin(); it != actions_actors2.end(); ++it)
        //  for (size_t ii = 0; ii < (*it).size(); ++ii)
        //    CRAWL( '\t' << (*it)[ii]);
        //CRAWL('\n');
        
        //EUCLIDIAN DISTANCE
        double max = 0;
        std::deque <Action> :: iterator i_max, it;
        for( it=actions_actors2.begin(); it != actions_actors2.end(); ++it)
        { 
          double dist = sum(pow(actions_actors2.at(ii).v - mean, 2));
          if (dist > max)
          {
            max = dist;
            i_max = it;
          }
        }
        
        CRAWL("MultiPolicy:: after euclidian distance \n");

        //retirando apenas o elemento que está no index i_max
        actions_actors2.erase (i_max);

        //PRINTLN
        //for(size_t ii=0; ii < actions_actors2.size(); ++ii)
        //  CRAWL("MultiPolicy:: after remove the i_max actions_actors2: " << actions_actors2[ii]);

        for (size_t ii=0; ii < mean.size(); ++ii)
          mean[ii] = 0;
        
        bool first = true;
        for(std::deque<Action>::iterator it = actions_actors2.begin(); it != actions_actors2.end(); ++it)
        {
          if (first)
            mean = it->v;
          else
            mean = mean + it->v;
          first = false;
          CRAWL("MultiPolicy::actions_actors2[ii="<< ii <<"].v: " << actions_actors2[ii].v << " mean: " << mean  << "\n");
        }
        mean = mean / actions_actors2.size();
        CRAWL("MultiPolicy::(mean / actions_actors2.size()): " << mean << "\n");
      }

      dist = mean;
    }
    break;
        
    case csMean:
    {
      std::deque<Action> actions_actors2(policy_.size());
      LargeVector mean;
      bool first = true;
      size_t ii = 0;
      for(std::deque<Action>::iterator it = actions_actors2.begin(); it != actions_actors2.end(); ++it, ++ii)
      {
        policy_[ii]->act(in, &*it);
        if (first)
          mean = it->v;
        else
          mean = mean + it->v;
        first = false;
      }
      mean = mean / policy_.size();

      dist = mean;
    }
    break;
  }

  if (!finite(dist[0]))
  {
    ERROR("Result %f is not finite!" << dist[0]);
    ERROR("n_dimension: " << n_dimension);
  }

  *out = dist;//variants[action];
  out->type = atExploratory;
  
  CRAWL("MultiPolicy::(*out): " << (*out) << "\n");
  
}

void DiscreteMultiPolicy::request(ConfigurationRequest *config)
{
  config->push_back(CRP("strategy", "Combination strategy", strategy_str_, CRP::Configuration, {"policy_strategy_add_prob", "policy_strategy_multiply_prob", "policy_strategy_majority_voting_prob", "policy_strategy_rank_voting_prob", "policy_strategy_density_based"}));
  config->push_back(CRP("tau", "Temperature of Boltzmann distribution", tau_));
  config->push_back(CRP("discretizer", "discretizer.action", "Action discretizer", discretizer_));
  config->push_back(CRP("policy", "mapping/policy/discrete", "Sub-policies", &policy_));
  config->push_back(CRP("r_distance_parameter", "R Distance Parameter", r_distance_parameter_));
  
  config->push_back(CRP("output_min", "vector.action_min", "Lower limit on outputs", min_, CRP::System));
  config->push_back(CRP("output_max", "vector.action_max", "Upper limit on outputs", max_, CRP::System));
}

void DiscreteMultiPolicy::configure(Configuration &config)
{
  CRAWL("tmp in DiscreteMultiPolicy::configure(Configuration &config)");
  
  strategy_str_ = config["strategy"].str();
  if (strategy_str_ == "policy_strategy_add_prob")
    strategy_ = csAddProbabilities;
  else if (strategy_str_ == "policy_strategy_multiply_prob")
    strategy_ = csMultiplyProbabilities;
  else if (strategy_str_ == "policy_strategy_majority_voting_prob")
    strategy_ = csMajorityVotingProbabilities;
  else if (strategy_str_ == "policy_strategy_rank_voting_prob")
    strategy_ = csRankVotingProbabilities;
  else if(strategy_str_ == "policy_strategy_density_based")
    strategy_ = csDensityBased;
  else
    throw bad_param("mapping/policy/discrete/multi:strategy");

  tau_ = config["tau"];
  r_distance_parameter_ = config["r_distance_parameter"];
  
  discretizer_ = (Discretizer*)config["discretizer"].ptr();
  
  policy_ = *(ConfigurableList*)config["policy"].ptr();

  min_ = config["output_min"].v();
  max_ = config["output_max"].v();

  if (min_.size() != max_.size() || !min_.size())
    throw bad_param("policy/action:{output_min,output_max}");
  
  if (policy_.empty())
    throw bad_param("mapping/policy/discrete/multi:policy");
  
  CRAWL("tmp out DiscreteMultiPolicy::configure(Configuration &config)");
}

void DiscreteMultiPolicy::reconfigure(const Configuration &config)
{
}

void DiscreteMultiPolicy::act(const Observation &in, Action *out) const
{
  LargeVector dist;
  distribution(in, *out, &dist);
  size_t action = sample(dist);

  std::vector<Vector> variants;
  discretizer_->options(in, &variants);
  if (action >= variants.size())
  {
    ERROR("Subpolicy action out of bounds: " << action << " >= " << variants.size());
    throw bad_param("mapping/policy/discrete/multi:policy");
  }

  *out = variants[action];
  
  out->type = atExploratory;
}

void DiscreteMultiPolicy::act(double time, const Observation &in, Action *out)
{
  // Call downstream policies to update time
  for (size_t ii=0; ii != policy_.size(); ++ii)
  {
    Action temp = *out;
    policy_[ii]->act(time, in, &temp);
  }
    
  // Then continue with usual action selection
  act(in, out);
}

void DiscreteMultiPolicy::distribution(const Observation &in, const Action &prev, LargeVector *out) const
{
  LargeVector dist;
  LargeVector param_choice;
  
  switch (strategy_)
  {
    case csAddProbabilities:

      policy_[0]->distribution(in, prev, out);
      param_choice = LargeVector::Zero(out->size());
      
      for (size_t ii = 0; ii != out->size(); ++ii) {
        if (std::isnan((*out)[ii]))
        {
          ERROR("MultiPolicy::param_choice::csAddProbabilities policy_[0] out(ii:" << ii << ") " << (*out)[ii]);
          for (size_t kk=0; kk < out->size(); ++kk)
            ERROR("MultiPolicy::dist::csAddProbabilities out(kk:" << kk << ") " << (*out)[kk]);
        }
      }
      
      for (size_t ii=0; ii != policy_.size(); ++ii)
      {
        // Add subsequent policies' probabilities according to chosen strategy
        policy_[ii]->distribution(in, prev, &dist);
        
        CRAWL("MultiPolicy::dist: " << dist);
        
        if (dist.size() != out->size())
        {
          ERROR("Subpolicy " << ii << " has incompatible number of actions");
          throw bad_param("mapping/policy/discrete/multi:policy");
        }

        for (size_t jj=0; jj < dist.size(); ++jj)
        {
          param_choice[jj] += dist[jj];
        
          if (std::isnan(param_choice[jj]))
          {
            ERROR("MultiPolicy::param_choice::csAddProbabilities (jj:" << jj << ") " << param_choice[jj]);
            for (size_t kk=0; kk < dist.size(); ++kk)
              ERROR("MultiPolicy::dist::csAddProbabilities (kk:" << kk << ") " << dist[kk]);
          }
        }
      }
      
      CRAWL("DiscreteMultiPolicy::param_choice: " << param_choice);

      normalized_function(param_choice, out);
      CRAWL("DiscreteMultiPolicy::out: " << (*out) << "\n");
      break;
        
    case csMultiplyProbabilities:
        
      policy_[0]->distribution(in, prev, out);
      param_choice = LargeVector::Ones(out->size());

      for (size_t ii=0; ii != policy_.size(); ++ii)
      {
        // Multiply subsequent policies' probabilities according to chosen strategy
        policy_[ii]->distribution(in, prev, &dist);
        
        CRAWL("MultiPolicy::dist: " << dist);
        
        if (dist.size() != out->size())
        {
          ERROR("Subpolicy " << ii << " has incompatible number of actions");
          throw bad_param("mapping/policy/discrete/multi:policy");
        }

        for (size_t jj=0; jj < dist.size(); ++jj)
          param_choice[jj] *= dist[jj];
      }
      
      CRAWL("DiscreteMultiPolicy::param_choice: " << param_choice);
      normalized_function(param_choice, out);
      CRAWL("DiscreteMultiPolicy::out: " << (*out) << "\n");
      
      break;
        
    case csMajorityVotingProbabilities:
      
      policy_[0]->distribution(in, prev, out);
      param_choice = LargeVector::Zero(out->size());
        
      for (size_t ii=0; ii != policy_.size(); ++ii)
      {
        policy_[ii]->distribution(in, prev, &dist);
        
        CRAWL("MultiPolicy::dist: " << dist);
        
        if (dist.size() != out->size())
        {
          ERROR("Subpolicy " << ii << " has incompatible number of actions");
          throw bad_param("mapping/policy/discrete/multi:policy");
        }
                
        double p_best_ind = 0.0;
        short i_ind = dist.size() - 1;
        for (size_t jj=0; jj < dist.size(); ++jj)
        {
          if (dist[jj] > p_best_ind)
          {
            p_best_ind = dist[jj];
            i_ind = jj;
          }
        }
        param_choice[i_ind] += 1;
      }
      
      CRAWL("DiscreteMultiPolicy::param_choice: " << param_choice);
      softmax(param_choice, out);
      CRAWL("DiscreteMultiPolicy::out: " << (*out));
      
      break;
        
    case csRankVotingProbabilities:
      {
      
      LargeVector rank_weights;
      
      policy_[0]->distribution(in, prev, out);
      param_choice = LargeVector::Zero(out->size());
        
      for (size_t ii=0; ii != policy_.size(); ++ii)
      {
        policy_[ii]->distribution(in, prev, &dist);
        
        CRAWL("MultiPolicy::dist: " << dist);
        
        if (dist.size() != out->size())
        {
          ERROR("Subpolicy " << ii << " has incompatible number of actions");
          throw bad_param("mapping/policy/discrete/multi:policy");
        }
        
        CRAWL("DiscreteMultiPolicy::dist: " << dist);
        //raking        
        rank_weights = LargeVector::Ones(out->size());
        for (size_t jj=0; jj < dist.size(); ++jj)
        {
          
          for (size_t kk = 0; kk < dist.size(); kk++)
          {
            if(dist[jj] > dist[kk])
              ++rank_weights[jj];
            CRAWL("DiscreteMultiPolicy::dist[: " << jj << "](" << dist[jj] << ") > dist [" << kk << "](" << dist[kk] << "): rank_weights[" << jj << "]("  << rank_weights[jj] << ")");
          }
          CRAWL("DiscreteMultiPolicy::policy: " << ii);
          CRAWL("DiscreteMultiPolicy::rank_weights: " << rank_weights);
          CRAWL("\nDiscreteMultiPolicy::param_choice: " << param_choice << '\n');
          param_choice[jj] += rank_weights[jj];
          CRAWL("\nDiscreteMultiPolicy::param_choice: " << param_choice << '\n');
        }
      }
      
      CRAWL("\nDiscreteMultiPolicy::param_choice: " << param_choice << '\n');
      softmax(param_choice, out);
      CRAWL("DiscreteMultiPolicy::out: " << (*out));
      }
      break;
        
    case csDensityBased:
    {
      LargeVector dist;
      Action tmp_action;
      std::vector<Action> actions_actors(policy_.size());
      policy_[0]->act(in, &actions_actors[0]);
      int n_dimension = actions_actors[0].v.size();
      int n_policies = policy_.size();
      double* result = new double[n_dimension];
      size_t ii_max = 0;
      std::string strspace = "";
      for(size_t kk=0; kk < 32; ++kk)
        strspace += " ";

      std::vector<Action> aa_normalized(n_policies);
      std::vector<double> density(n_policies);
      std::vector<size_t> ii_max_density;
      double exp_result = 0.0;
  
      size_t ii = 0;
      dist = LargeVector::Zero(n_policies);
      
      Vector send_actions(n_policies);
      
      Action tmp;
      std::vector<Action>::iterator it_norm = aa_normalized.begin();
      for(std::vector<Action>::iterator it = actions_actors.begin(); it != actions_actors.end(); ++it, ++ii)
      {
        policy_[ii]->act(in, &*it);
        tmp.v = -1 + 2*( ((*it).v - min_) / (max_ - min_) );
        (*it_norm) = tmp;
        ++it_norm;
        CRAWL("ii: " << ii << " actions_actors: " << (*it).v << " normalized: " << tmp.v);

        send_actions[ii] = it->v[0];
      }

      //action_->set(send_actions);

      double max = -1 * std::numeric_limits<double>::infinity();
      std::vector<Action>::iterator it, it2, i_max;
      ii = 0;
      for( it=aa_normalized.begin(); it != aa_normalized.end(); ++it, ++ii)
      {
        std::string strtmp = "";
        double r_dist = 0.0;
        for( it2=aa_normalized.begin(); it2 != aa_normalized.end(); ++it2)
        {
          double expoent = 0.0;
          for(size_t jj = 0; jj != n_dimension; ++jj)
          {
            expoent += pow((*it).v[jj] - (*it2).v[jj], 2);
            //strtmp += strspace + "expoent(jj:" + std::to_string(jj) + "): " +  std::to_string(expoent) + " (1): " + std::to_string((*it).v[jj]) + " (2): " + std::to_string((*it2).v[jj]) + "\n";
          }
          //strtmp += strspace + strspace + "r_dist(before): " + std::to_string(r_dist) + " expoent: " + std::to_string((-1 * expoent / pow(r_distance_parameter_, 2))) + " exp: " + std::to_string(exp( -1 * expoent / pow(r_distance_parameter_, 2))) + "\n";
          r_dist = r_dist + exp( -1 * expoent / pow(r_distance_parameter_, 2) );
        }
        density.push_back( r_dist );
        //CRAWL(strtmp << strspace << "sum(expo) - density[ii:" << ii << "]: " << r_dist );
        if (r_dist > max)
        {
          max = r_dist;
          //CRAWL("******************************************************************max(ii:"<<ii<<") = " << max );
          i_max = it;
          ii_max_density.clear();
          ii_max_density.push_back(ii);
          //ii_max = ii;
        } else if (r_dist == max)
        {
          //CRAWL("******************************************************************max(ii:"<<ii<<") = " << max );
          ii_max_density.push_back(ii);
        }
      }

      for (size_t jj=0; jj < n_dimension; ++jj)
      {
        int aleatorio = rand();
        size_t index = ii_max_density.at(aleatorio%ii_max_density.size());
        CRAWL( "MultiPolicy::ii_max_density.size(): " << ii_max_density.size() << " aleatorio: " << aleatorio << " index: " << index);
        result[jj] = actions_actors[index].v[jj];
        //CRAWL( "MultiPolicy::result_[ii_max=" << index << "][jj:" << jj << "]: " << result[jj] );
      }

      dist = ConstantLargeVector( n_dimension, *result );
    }
    break;
  }      
}

void DiscreteMultiPolicy::softmax(const LargeVector &values, LargeVector *distribution) const
{
  LargeVector v = LargeVector::Zero(values.size());
  for (size_t ii=0; ii < values.size(); ++ii)
    if (std::isnan(values[ii]))
      ERROR("SoftmaxSampler: NaN value in Boltzmann distribution 1");

  distribution->resize(values.size());
  const double threshold = -100;

  // Find max_power and min_power, and center of feasible powers
  double max_power = -DBL_MAX;
  for (size_t ii=0; ii < values.size(); ++ii)
  {
    double p = values[ii]/tau_;
    max_power = (max_power < p) ? p : max_power;
  }
  double min_power = max_power + threshold;
  double center = (max_power+min_power)/2.0;

  // Discard powers from interval [0.0; threshold] * max_power
  double sum = 0;
  for (size_t ii=0; ii < values.size(); ++ii)
  {
    double p = values[ii]/tau_;
    if (p > min_power)
    {
      p -= center;
      v[ii] = exp(p);
      sum += v[ii];
      (*distribution)[ii] = 1;

      if (std::isnan(v[ii]))
        ERROR("SoftmaxSampler: NaN value in Boltzmann distribution 2");
    }
    else
      (*distribution)[ii] = 0;
  }

  for (size_t ii=0; ii < values.size(); ++ii)
  {
    (*distribution)[ii] *= v[ii]/sum;
    if (std::isnan((*distribution)[ii]))
      ERROR("SoftmaxSampler: NaN value in Boltzmann distribution 4");
  }
}

void DiscreteMultiPolicy::normalized_function(const LargeVector &values, LargeVector *distribution) const
{  
  LargeVector v = LargeVector::Zero(values.size());
  for (size_t ii=0; ii < values.size(); ++ii)
    if (std::isnan(values[ii]))
      ERROR("normalized_function: NaN value in  distribution 1");

  distribution->resize(values.size());
  const double threshold = -100;

  // Find max_power and min_power, and center of feasible powers
  double max_power = -DBL_MAX;
  for (size_t ii=0; ii < values.size(); ++ii)
  {
    double p = 1.0/tau_;
    max_power = (max_power < p) ? p : max_power;
  }
  double min_power = max_power + threshold;
  double center = (max_power+min_power)/2.0;

  // Discard powers from interval [0.0; threshold] * max_power
  double sum = 0;
  for (size_t ii=0; ii < values.size(); ++ii)
  {
    double p = 1.0/tau_;
    if (p > min_power)
    {
      p -= center;
      v[ii] = pow(values[ii], p);
      sum += v[ii];
      (*distribution)[ii] = 1;

      if (std::isnan(v[ii])) 
        ERROR("normalized_function: NaN value in  distribution 2");
    }
    else {
      (*distribution)[ii] = 0;
    }
  }

  for (size_t ii=0; ii < values.size(); ++ii)
  {
    (*distribution)[ii] *= v[ii]/sum;
    if (std::isnan((*distribution)[ii]))
      ERROR("normalized_function: NaN value in  distribution 4");
  }
}
