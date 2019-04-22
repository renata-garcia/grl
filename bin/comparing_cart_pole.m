clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 33;

%% MPOL DPG CARTPOLE 
compare_executions(n, folder, 2, 909, 'MPOL DPG CARTPOLE',...
  "cart_pole_dpg_data",...  
  "cartpole_q_data");

%% MPOL DPG CARTPOLE 
n = 10;
compare_executions(n, folder, 2, 90, 'MPOL DDPG CARTPOLE',...
  "cart_pole_dpg_data",...  
  "cartpole_q_data",...
  "cartpole_mpol_1_replay_ddpg_tensorflow_data");

%%
%Interval 10.000
%reward scale 0.1
%replay 128, batch_size 52
title_fig = "FINDING BEST SINGLE CART POLE";
array_runs = ["cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*.txt",...
    "cartPoleMpolDdpg16V2Alg4stepsNoneDensity100BestA001*.txt",...
    "cartPoleMpolDdpg16V2MeanEuclidianDistance010BestA001*.txt"];

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
%Interval 10.000
%reward scale 0.1
%replay 128, batch_size 52
array_runs = ["cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*.txt",...
    "cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128*.txt" , ...
    "cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*.txt",...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64*.txt" , ...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128*.txt" , ...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256*.txt" , ...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*.txt",...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128*.txt" , ...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256*.txt" , ...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64*.txt" , ...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128*.txt" , ...
"cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
%Interval 10.000
%reward scale 0.1
%replay 128, batch_size 52
title_fig = "TRYING MPOL CART POLE";
array_runs = ["cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*.txt",...
    "cartPoleMpolDdpg16Alg4stepsNoneDensity100BestA001*.txt",... %none_density_100_best
    "cartPoleMpolDdpg16V2Alg4stepsNoneDensity100BestA001*.txt"];

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
%Interval 10.000
%reward scale 0.1
%replay 128, batch_size 52
title_fig = "TRYING MPOL CART POLE";
array_runs = ["cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*.txt",...
    "cartPoleMpolDdpg16V2MeanEuclidianDistance010BestA001*.txt",...
    "cartPoleMpolDdpg16V3Alg4stepsMeanEuclidian010BestA001*.txt"];

ploting_executions(folder, title_fig, steps_per_second, array_runs);

