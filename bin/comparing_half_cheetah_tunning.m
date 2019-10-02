clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/half_cheetah_tuning/";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 1;
%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps128_batch_size128_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps128_batch_size256_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps128_batch_size512_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps128_batch_size64_interval1000_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps128_batch_size64_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt"];
title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size256_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size512_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size256_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size512_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval1000_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps64_batch_size128_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps64_batch_size256_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps64_batch_size512_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps64_batch_size64_interval1000_gamma0.4_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps64_batch_size64_interval400_gamma0.4_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.4_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.7_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.9_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval2000_gamma0.75_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval400_gamma0.75_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10000_gamma0.75_reward_scale1.0_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.75_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.7_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.9_reward_scale1.0_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.85_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.85_reward_scale0.1_sigma[2]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.85_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.85_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.8_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.8_reward_scale0.1_sigma[2]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.8_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.8_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.99_reward_scale0.1_sigma[2]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.99_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.99_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.85_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.85_reward_scale0.1_sigma[2]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.85_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.85_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.8_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.8_reward_scale0.1_sigma[2]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.8_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.8_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale0.1_sigma[2]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale1.0_sigma[2]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.8_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.85_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale1.0_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
