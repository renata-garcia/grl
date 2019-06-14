clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
subfolder = "pendulum_yamls_results/";
preffix = "pendulum_replay_ddpg_tensorflow_sincos_i";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 30;

%%

env = "leosim";
subfolder = env + "_results/";
% preffix = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16";
% 
% type = "good";
% title_fig = [env, "MPOL ", type];
% 
% subfolder2 = "cart_pole_mpols_load_yamls_results/";
% preffix2 = "cart_pole_cp_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load";

array_runs = [subfolder + "leosim_ddpg*txt"];

title_fig = "";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
