clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/leosim_tuning_results/";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 30;
%%
array_runs = [
    "leo_leosim_ddpg_replay_steps32_batch_size64_interval400_gamma0.73_reward_scale0.01_sigma[1] _*txt",...
    "leo_leosim_ddpg_replay_steps64_batch_size64_interval400_gamma0.73_reward_scale0.01_sigma[1] _*txt",...
    "leo_leosim_ddpg_replay_steps128_batch_size64_interval400_gamma0.73_reward_scale0.01_sigma[1] _*txt",...
    "leo_ddpg_replay_steps64_batch_size384_interval1000_gamma0.75_reward_scale1.0_sigma[2]*txt"];
title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.45_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.75_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size128_interval1000_gamma0.75_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps384_batch_size64_interval1000_gamma0.75_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps512_batch_size64_interval1000_gamma0.75_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps512_batch_size128_interval1000_gamma0.75_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.85_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%%
array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.55_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.6_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.65_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt",...
"../leosim_tunning_rnd_notau_results/*txt",...
"../leosim_tunning_nornd_tau_results/*txt",...
"../leosim_tunning_rnd_tau_results/*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt",...
"../leosim_tunning_nornd_notau_results/*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt",...
"leo_ddpg_replay_steps512_batch_size128_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt",...
"leo_ddpg_replay_steps512_batch_size128_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval10000_gamma0.5_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[1]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale0.1_sigma[2]*txt",...
"leo_ddpg_replay_steps128_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval10000_gamma0.5_reward_scale1.0_sigma[2]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.5_reward_scale1.0_sigma[3]*txt",...
"leo_ddpg_replay_steps256_batch_size64_interval1000_gamma0.55_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE LEOSIM";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

% 
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
%     "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt",...
%     "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt"];
% title_fig = "FINDING BEST SINGLE CART POLE";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 1";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 2";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% %
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 3";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% %
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 4";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% %
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 5";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% %
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 6";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% %
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 7";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% %
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 8";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% %
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 9";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval10000_gamma0.99_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.98_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.98_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 10";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval10000_gamma0.99_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval4000_gamma0.98_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval4000_gamma0.98_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval4000_gamma0.99_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval4000_gamma0.99_reward_scale0.1_*txt"];
% title_fig = "FINDING BEST SINGLE CART POLE  11";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% 
% 
% %%
% array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
% "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt"];
% title_fig = "FINDING BEST SINGLE CART POLE 12";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
