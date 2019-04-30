clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 33;

%%
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum',...
    "pendulum_ac_tc",...
    "pendulum_dpg.dat",...        %%%
    "pendulum_dpg_rand_",...
    "pendulum_dpg_rand_sincos",...
    "replay_ddpg_tensorflow_sincos_");  %%%

%%
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "replay_ddpg_tensorflow_rand1_sincos_",...
    "replay_ddpg_tensorflow_sincos_");

%%%% TODO:
%%%%%%%% "replay_ddpg_tensorflow_rand1_sincos_",...
%%%%%%%% "replay_ddpg_tensorflow_sincos_");

%%
n_old = n;
n = 19;
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum',...
    "replay_ddpg_tensorflow_lra3_");
n = n_old;

%%
compare_executions(n, folder, 0, 909, 'MPOL 2 DPG benchmark',...
    "pendulum_dpg.dat",...
    "mpol_dpg_2_data_center_voting_mov_data",...
    "mpol_dpg_2_data_center_voting_mov_two_steps_data",...
    "mpol_dpg_2_data_center_equals_data",...
    "mpol_dpg_2_data_center_data");

%%
n_old = n;
n = 8;
compare_executions(n, folder, 0, 909, 'MPOL DDPG benchmark',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "mpol_1_replay_ddpg_tensorflow_rand1_batchsize32_decay99_data",...
    "mpol_1_replay_ddpg_tensorflow_rand1_decay99_data");
n = n_old;

%%
compare_executions(n, folder, 0, 454, 'MPOL DDPG benchmark',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "mpol_ddpg_2_density_based_random_data",...
    "mpol_ddpg_2_density_based__mm_a90_data",...
    "mpol_ddpg_2_density_based_rand_mm_a90_data",...
    "mpol_ddpg_2_density_based_rand_bm_a90_data");

%%
compare_executions(n, folder, 0, 909, 'MPOL DDPG benchmark',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "mpol_ddpg_2_density_based_random_data");


%%
compare_executions(n, folder, 0, 909, 'MPOL DDPG benchmark',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "mpol_ddpg_4_density_based_data",...
    "mpol_ddpg_4_density_based_bm_a90_data",...
    "mpol_ddpg_4_density_based_dr99_data",...
    "mpol_ddpg_4_density_based_dens_best_data",...
    "mpol_ddpg_4_data_center_data",...
    "mpol_ddpg_4_data_center_voting_mov_data",...
    "mpol_ddpg_4_data_center_dr99_data");


%%
n_old = n;
n = 2;
compare_executions(n, folder, 0, 45, 'MPOL DDPG benchmark',...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_memsize1E5_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_memsize1E6_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_bacthsize128_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_obssteps1000_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_obssteps500_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_obssteps500_memsize1E6_");
n = n_old;

%%
n_old = n;
n = 4;

compare_executions(n, folder, 0, 909, 'MPOL DDPG benchmark',...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_9876_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_9888_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_9889_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_9899_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_9989_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_9999_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_8_3l8_");

compare_executions(n, folder, 0, 909, 'MPOL DDPG benchmark',...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_density_based_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_density_based_9888_",...    
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_density_based_9889_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_density_based_9899_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_density_based_9989_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_density_based_9999_");

n = n_old;

%%
n_old = n;
n = 6;
compare_executions(n, folder, 0, 909, 'MPOL DDPG benchmark',...
    "replay_ddpg_tensorflow_3l8_",...
    "replay_ddpg_tensorflow_sincos_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_8_3l8_",...
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_density_based_8_3l8_",... %8
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_density_max_none_8_3l8_mem909_",...%6
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_data_center_8_3l8_mem909_",... %3
    "mpol_ddpg_4_rand1_sincos_alg4steps_none_none_none_density_based_8_3l8_mem909_"); %9
n = n_old;

%% MPOL DPG 16 PENDULUM
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum',...
    "pendulum_dpg_rand_sincos",...
	"pendulum_mpol_dpg_16_mean_euclidian_distance_0.1_best_a0.01_pp0_",...
	"pendulum_mpol_dpg_16_mean_euclidian_distance_0.5_data_center_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_mean_euclidian_distance_0.5_density_a0.01_pp0_",...
	"pendulum_mpol_dpg_16_none_data_center_linear_order_1.0_best_a0.01_pp0_");
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum',...
    "pendulum_dpg_rand_sincos",...
    "pendulum_mpol_dpg_16_density_euclidian_distance_0.01_best_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_none_density_0.5_data_center_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_none_density_0.5_density_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_none_density_1.0_best_a0.01_pp0_",...
	"pendulum_mpol_dpg_16_none_none_1.0_mean_a1_pp0_",...
    "pendulum_mpol_dpg_16_none_none_1.0_random_a1_pp0_",...
	"pendulum_mpol_dpg_16_none_none_1_data_center_a1.0_pp0_",...
	"pendulum_mpol_dpg_16_none_none_1_density_a1_pp0_");

%% MPOL DPG 16 PENDULUM 2
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum 2',...
    "pendulum_dpg_rand_sincos",...
	"pendulum_mpol_dpg_16_2_mean_euclidian_distance_0.1_best_a0.01_pp0_",...
	"pendulum_mpol_dpg_16_2_mean_euclidian_distance_0.5_data_center_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_2_mean_euclidian_distance_0.5_density_a0.01_pp0_",...
	"pendulum_mpol_dpg_16_2_none_data_center_linear_order_1.0_best_a0.01_pp0_");
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum 2',...
    "pendulum_dpg_rand_sincos",...
    "pendulum_mpol_dpg_16_2_density_euclidian_distance_0.01_best_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_2_none_density_0.5_data_center_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_2_none_density_0.5_density_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_2_none_density_1.0_best_a0.01_pp0_",...
    "pendulum_mpol_dpg_16_2_none_none_1.0_data_center_a1.0_pp0_",...
    "pendulum_mpol_dpg_16_2_none_none_1.0_density_a1.0_pp0_",...
    "pendulum_mpol_dpg_16_2_none_none_1.0_mean_a1.0_pp0_",...
    "pendulum_mpol_dpg_16_2_none_none_1.0_random_a1_pp0_");

%% MPOL DPG 16 PENDULUM 3
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum 3',...
    "pendulum_dpg_rand_sincos",...
    "pend3/pendulum_mpol_dpg_16_3_density_euclidian_distance_0.01_best_a0.01_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_mean_euclidian_distance_0.1_best_a0.01_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_mean_euclidian_distance_0.5_data_center_a0.01_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_mean_euclidian_distance_0.5_density_a0.01_pp0_");
compare_executions(n, folder, 1, 909, 'Algoritmos Pendulum 3',...
    "pendulum_dpg_rand_sincos",...pendulum_mpol_dpg_16_3_none_data_center_linear_order_1.0_best_a0.01_pp0_.yaml
    "pend3/pendulum_mpol_dpg_16_3_none_density_0.5_data_center_a0.01_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_none_density_0.5_density_a0.01_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_none_density_1.0_best_a0.01_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_none_none_1.0_data_center_a1.0_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_none_none_1.0_density_a1.0_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_none_none_1.0_mean_a1.0_pp0_",...
    "pend3/pendulum_mpol_dpg_16_3_none_none_1.0_random_a1_pp0_");




%% MOVIDOS PARA OLDIES
% "mpol_dpg_13_density_based_data",
% "pendulum_mpol_dpg_13_density_based_euclidian_distance_1.0_mean_a1.0_pp0",
% "pendulum_mpol_dpg_13_data_center_euclidian_distance_1.0_mean_a1.0_pp0"
% mpol_dpg_13_random_data
% mpol_dpg_13_mean_mov_data
% mpol_dpg_13_mean_data
% "mpol_dpg_13_data_center_data"
% pendulum_mpol_dpg_13_*
% mpol_dpg_13_data_center_bm_a90_data
% mpol_dpg_13_data_center_voting_mov_two_steps_data
% mpol_dpg_13_data_center_voting_mov_data
% mpol_dpg_13_density_based_bm_a90_data
% mpol_dpg_13_density_based_historic_dens_data
% mpol_dpg_13_density_based_historic_a10_data
% mpol_dpg_13_density_based_dens_best_data
% "mpol_dpg_13_density_based_voting_mov_data"
compare_executions(n, folder, 0, 909, 'MPOL DPG 13 benchmark',...
    "pendulum_dpg.dat",  ...
    "mpol_dpg_13_greedy_data",...
    "mpol_dpg_13_density_based_voting_mov_data");
%%
% "mpol_dpg_20_density_based_data"
% "mpol_dpg_20_density_based_bm_a90_data"
% "mpol_dpg_20_density_based_mm_a001_data"
% "mpol_dpg_20_density_based_historic_dens_data"
% "mpol_dpg_20_density_based_historic_data"
% "mpol_dpg_20_density_based_historic_a001_data"
% "mpol_dpg_20_data_center_data"
% "mpol_dpg_20_data_center_voting_mov_two_steps_data"
% "mpol_dpg_20_density_based_historic_a10_data"
% "mpol_dpg_20_density_based_dens_best_data"
% "mpol_dpg_20_data_center_bm_a90_data"

%% MPOL DPG 26 DATA_CENTER 1
compare_executions(n, folder, 0, 909, 'MPOL DPG 26 DATA CENTER 1',...
    "pendulum_dpg.dat", "mpol_dpg_26_data_center_mean_mov_a001_data", ...
    "mpol_dpg_26_data_center_voting_mov_data",...
    "mpol_dpg_26_data_center_data",...
    "mpol_dpg_26_data_center_mean_mov_a01_data", "mpol_dpg_26_data_center_mean_mov_a001_data",...
    "mpol_dpg_26_data_center_mean_mov_a01_data", "mpol_dpg_26_data_center_mean_mov_a10_data",...
    "mpol_dpg_26_data_center_mean_mov_a20_data",  "mpol_dpg_26_data_center_bm_a90_data",...
    "mpol_dpg_26_data_center_voting_mov_two_steps_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 0, 909, 'MPOL DPG 26 DENSITY BASED TODOS/BC',...
    "pendulum_dpg.dat", ...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_historic_dens_data",...
    "mpol_dpg_26_density_based_dens_best_data",...
    "mpol_dpg_26_density_based_mm_a90_data", "mpol_dpg_26_density_based_historic_a10_data",...
    "mpol_dpg_26_density_based_historic_data", "mpol_dpg_26_density_based_historic_a001_data",...
    "mpol_dpg_26_density_based_bm_a90_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 0, 909, 'MPOL DPG 26 DENSITY BASED TODOS/BC',...
    "mpol_dpg_26_density_based_historic_a10_data",...
    "mpol_dpg_26_density_based_historic_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 0, 909, 'MPOL DPG 26 DENSITY BASED BC',...
    "pendulum_dpg.dat", "mpol_dpg_26_data_center_bm_a90_data",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_historic_dens_data",...
    "mpol_dpg_26_data_center_data",...
    "mpol_dpg_26_density_based_dens_best_data",...
    "mpol_dpg_26_density_based_bm_a90_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 0, 909, 'MPOL DPG 26 DENSITY BASED BC',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_historic_dens_data",...
    "mpol_dpg_26_density_based_dens_best_data",...
    "mpol_dpg_26_density_based_bm_a90_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 2, 909, 'MPOL DPG 26 DENSITY BASED DB vs BM',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_bm_a90_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 1, 909, 'MPOL DPG 26 DENSITY BASED DB vs DB',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_dens_best_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 1, 909, 'MPOL DPG 26 DENSITY BASED DB vs HD',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_historic_dens_data");

%% MPOL DPG 26 Density based NOVA IMPLEMENTACAO
compare_executions(n, folder, 1, 909, 'MPOL DPG 26 ALG4STEPNEW',...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_alg4stepsnew_none_dens_100_best_a100_",...
    "mpol_dpg_26_alg4stepsnew_none_dens_none_1_best_0_",...
    "mpol_dpg_26_density_based_historic_dens_data");

%%
compare_executions(n, folder, 1, 909, 'MPOL DPG 26 BC',...
    "pendulum_dpg.dat", "mpol_dpg_26_alg4steps_dens_dens_max_none_data",...
    "mpol_dpg_26_density_based_bm_a01_discretetime_data",...
    "mpol_dpg_26_density_based_bm_a90_",...
    "mpol_dpg_26_density_based_bm_a90_data",...
    "mpol_dpg_26_density_based_dens_best_data");

%%
compare_executions(n, folder, 1, 909, 'MPOL DPG 26 BC',...
    "mpol_dpg_26_density_based_bm_a10_discretetime_",...
    "mpol_dpg_26_density_based_bm_a01_discretetime_data");

compare_executions(n, folder, 1, 909, 'MPOL DPG 26 BC',...
    "mpol_dpg_26_density_based_bm_a01_discretetime_data",...
    "mpol_dpg_26_density_based_bm_a01_");

compare_executions(n, folder, 1, 909, 'MPOL DPG 26 BC',...
    "mpol_dpg_26_density_based_bm_a10_discretetime_",...
    "mpol_dpg_26_density_based_bm_a01_discretetime_data",...
    "mpol_dpg_26_density_based_bm_a01_");

%%
compare_executions(n, folder, 0, 909, 'MPOL DPG 26 density based alpha bm',...
    "pendulum_dpg.dat",...
    'mpol_dpg_26_density_based_bm_a90_data',...
    'mpol_dpg_26_density_based_bm_a01_discretetime_data');


% %% %%
% array_runs = ["pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i16*txt",...
%               "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i20*txt"];
% title_fig = "FINDING BEST SINGLE PENDULUM V1";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% %%
% array_runs = ["pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i1*.txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i2*.txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i3*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i4*.txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i5*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i6*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i7*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i8*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i9*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i10*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i11*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i12*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i13*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i14*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i15*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i20*txt"];
% title_fig = "FINDING BEST SINGLE PENDULUM V1";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i1*.txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i2*.txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i3*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i4*.txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i5*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i6*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i7*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i8*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i9*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i10*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i11*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i12*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i13*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i14*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i15*txt",...
    "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i16*txt"];
title_fig = "FINDING BEST SINGLE PENDULUM V2";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

% %%
% array_runs = ["pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i17*.txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i18*.txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i19*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i20*.txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i21*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i22*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i23*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i24*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i25*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i26*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i27*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i28*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i29*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i30*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i31*txt",...
%     "pendulum_yamls_results/pendulum_replay_ddpg_tensorflow_sincos_i32*txt"];
% title_fig = "FINDING BEST SINGLE PENDULUM V3";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
