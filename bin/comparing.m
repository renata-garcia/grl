clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/");

%%
compare_executions(n, folder, 1, 'Algoritmos Pendulum',...
    "pendulum_ac_tc",...
    "pendulum_dpg.dat",...        %%%
    "pendulum_dpg_rand_",...
    "pendulum_dpg_rand_sincos",...
    "replay_ddpg_tensorflow_sincos_");  %%%

%%
compare_executions(n, folder, 1, 'Algoritmos Pendulum',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "replay_ddpg_tensorflow_rand1_sincos_",...
    "replay_ddpg_tensorflow_sincos_");

%%
n_old = n;
n = 19;
compare_executions(n, folder, 1, 'Algoritmos Pendulum',...
    "replay_ddpg_tensorflow_lra3_");
n = n_old;

%%
compare_executions(n, folder, 0, 'MPOL 2 DPG benchmark',...
    "pendulum_dpg.dat",...
    "mpol_dpg_2_data_center_voting_mov_data",...
    "mpol_dpg_2_data_center_voting_mov_two_steps_data",...
    "mpol_dpg_2_data_center_equals_data",...
    "mpol_dpg_2_data_center_data");

%%
n_old = n;
n = 8;
compare_executions(n, folder, 0, 'MPOL DDPG benchmark',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "mpol_1_replay_ddpg_tensorflow_rand1_batchsize32_decay99_data",...
    "mpol_1_replay_ddpg_tensorflow_rand1_decay99_data");
n = n_old;

%%
compare_executions(n, folder, 0, 'MPOL DDPG benchmark',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "mpol_ddpg_2_density_based_random_data",...
    "mpol_ddpg_2_density_based__mm_a90_data",...
    "mpol_ddpg_2_density_based_rand_mm_a90_data",...
    "mpol_ddpg_2_density_based_rand_bm_a90_data");

%%
compare_executions(n, folder, 0, 'MPOL DDPG benchmark',...
    "mpol_1_replay_ddpg_tensorflow_random_data",...
    "mpol_ddpg_2_density_based_random_data");


%%
compare_executions(n, folder, 0, 'MPOL DDPG benchmark',...
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
compare_executions(n, folder, 0, 'MPOL DDPG benchmark',...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_memsize1E5_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_memsize1E6_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_bacthsize128_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_obssteps1000_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_obssteps500_",...
    "mpol_ddpg_4_rand1_sincos_decay99_alg4steps_none_none_none_dens_obssteps500_memsize1E6_");
n = n_old;

%%
compare_executions(n, folder, 0, 'MPOL DPG 13 benchmark',...
    "pendulum_dpg.dat", "mpol_dpg_13_density_based_data",...
    "mpol_dpg_13_data_center_data", "mpol_dpg_13_random_data",...
    "mpol_dpg_13_greedy_data", "mpol_dpg_13_mean_mov_data",...
    "mpol_dpg_13_mean_data");

%%
compare_executions(n, folder, 1, 'MPOL DPG 13 benchmark',...
    "pendulum_dpg.dat", "mpol_dpg_13_density_based_data",...
    "mpol_dpg_13_data_center_data");

%%
compare_executions(n, folder, 0, 'MPOL DPG 13 data center bm',...
    "pendulum_dpg.dat",'mpol_dpg_13_data_center_data',...
    'mpol_dpg_13_data_center_bm_a90_data',...
    "mpol_dpg_13_data_center_voting_mov_two_steps_data",...
    "mpol_dpg_13_data_center_voting_mov_data",...
    'mpol_dpg_13_data_center_mm_b2_a01_data', 'mpol_dpg_13_data_center_mm_b2_a75_data',...
    'mpol_dpg_13_data_center_mm_b2_a90_data', 'mpol_dpg_13_data_center_mm_b2_a98_data');
% "../../../projects/grl/build/mpol_dpg_13_data_center_voting_mov_two_steps_data",...

%%
compare_executions(n, folder, 0, 'MPOL DPG 13 density based bm',...
    "pendulum_dpg.dat",'mpol_dpg_13_density_based_data',...
    'mpol_dpg_13_density_based_bm_a90_data',...
    "mpol_dpg_13_alg4steps_none_eucl_50asc_dens_data",...
    "mpol_dpg_13_density_based_historic_dens_data",...
    "mpol_dpg_13_alg4steps_dens_dens_max_none_data");

%%
compare_executions(n, folder, 0, 'MPOL DPG 13 density based bm',...
    "mpol_dpg_13_density_based_historic_dens_data",...
    "mpol_dpg_13_alg4steps_dens_dens_max_none_data");

%%
compare_executions(n, folder, 0, 'MPOL DPG 13 density based bm',...
    'mpol_dpg_13_density_based_bm_a90_data',...
    "mpol_dpg_13_alg4steps_none_eucl_50asc_dens_data");

%%
compare_executions(n, folder, 0, 'MPOL DPG 13 density based bm',...
    "pendulum_dpg.dat", "mpol_dpg_13_density_based_data",...
    "mpol_dpg_13_density_based_bm_a90_data",...
    "mpol_dpg_13_density_based_historic_a10_data",...
    "mpol_dpg_13_density_based_dens_best_data",...
    "mpol_dpg_13_density_based_historic_dens_data",...
    "mpol_dpg_13_density_based_historic_data", "mpol_dpg_26_density_based_historic_a001_data",...
    "mpol_dpg_13_density_based_mm_a90_data");

%%
compare_executions(n, folder, 0, 'MPOL DPG 13 BC',...
    "pendulum_dpg.dat", "mpol_dpg_13_density_based_bm_a90_data",...
    "mpol_dpg_13_data_center_bm_a90_data",...
    "mpol_dpg_13_density_based_dens_best_data",...
    "mpol_dpg_13_density_based_historic_dens_data",...
    "mpol_dpg_13_density_based_voting_mov_data");

%%
compare_executions(n, folder, 1, 'MPOL DPG 13 BC',...
    "pendulum_dpg.dat", "mpol_dpg_13_density_based_bm_a90_data",...
    "mpol_dpg_13_density_based_dens_best_data",...
    "mpol_dpg_13_density_based_historic_dens_data");

%%
compare_executions(n, folder, 1, 'MPOL DPG 13 BC',...
    "pendulum_dpg.dat",...
    "mpol_dpg_13_alg4steps_none_eucl_50asc_datacenter_data",...
    "mpol_dpg_13_alg4steps_none_eucl_50asc_dens_data",...
    "mpol_dpg_13_density_based_dens_best_data");

%%
compare_executions(n, folder, 1, 'MPOL DPG 13 ALG4STEPS dens.eucl',...
    "pendulum_dpg.dat",...
    "mpol_dpg_13_alg4steps_dens_eucl_50asc_dens_",... %VC
    "mpol_dpg_13_alg4steps_dens_eucl_min_none_");     %AC

compare_executions(n, folder, 1, 'MPOL DPG 26 ALG4STEPS dens.eucl',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_alg4steps_dens_eucl_50asc_dens_",... %AC
    "mpol_dpg_26_alg4steps_dens_eucl_min_none_");     %ABOVE

compare_executions(n, folder, 1, 'MPOL DPG 13 ALG4STEPS none.dens',...
    "pendulum_dpg.dat",...
    "mpol_dpg_13_alg4steps_none_dens_50desc_dens_",... %VC
    "mpol_dpg_13_alg4steps_none_dens_max_none_");      %ABOVE

compare_executions(n, folder, 1, 'MPOL DPG 26 ALG4STEPS none.dens',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_alg4steps_none_dens_50desc_dens_",... %VC
    "mpol_dpg_26_alg4steps_none_dens_max_none_");      %ABOVE

% NOT GOOD
% compare_executions(n, folder, 1, 'MPOL DPG 13 ALG4STEPS quartile',...
%     "pendulum_dpg.dat",...
%     "mpol_dpg_13_alg4steps_none_eucl_quartileMM_datacenter_",...
%     "mpol_dpg_13_alg4steps_none_eucl_quartileMM_dens_");
% 
% compare_executions(n, folder, 1, 'MPOL DPG 26 ALG4STEPS quartile',...
%     "pendulum_dpg.dat",...
%     "mpol_dpg_26_alg4steps_none_eucl_quartileMM_datacenter_",...
%     "mpol_dpg_26_alg4steps_none_eucl_quartileMM_dens_");

compare_executions(n, folder, 1, 'MPOL DPG 13 BC',...
    "pendulum_dpg.dat",...
    "mpol_dpg_13_alg4steps_none_none_none_datacenter_",...  %AC
    "mpol_dpg_13_alg4steps_none_none_none_dens_",...        %AC
    "mpol_dpg_26_alg4steps_none_eucl_50asc_datacenter_",... %VC
    "mpol_dpg_26_alg4steps_none_eucl_50asc_dens_");         %VC

compare_executions(n, folder, 1, 'MPOL DPG 13 BC',...
    "mpol_dpg_26_alg4steps_none_none_none_datacenter_",...
    "mpol_dpg_26_alg4steps_none_none_none_dens_");

%%
compare_executions(n, folder, 0, 'MPOL DPG 20 density based',...
    "pendulum_dpg.dat","mpol_dpg_20_density_based_data",...
    "mpol_dpg_20_density_based_bm_a90_data",...
    "mpol_dpg_20_density_based_mm_a001_data",...
    "mpol_dpg_20_density_based_historic_dens_data",...
    "mpol_dpg_20_density_based_historic_data", "mpol_dpg_20_density_based_historic_a001_data");

%%
compare_executions(n, folder, 2, 'MPOL DPG 20 density based',...
    "pendulum_dpg.dat",...
    "mpol_dpg_20_density_based_bm_a90_data",...
    "mpol_dpg_20_density_based_historic_dens_data");

%%
compare_executions(n, folder, 0, 'MPOL DPG 20 density based',...
    "mpol_dpg_20_density_based_data",...
    "mpol_dpg_20_density_based_mm_a001_data","mpol_dpg_20_density_based_mm_a01_data",...
    "mpol_dpg_20_density_based_mm_a75_data", "mpol_dpg_20_density_based_mm_a90_data");

%%
compare_executions(n, folder, 0, 'MPOL DPG 20 data center',...
    "pendulum_dpg.dat", "mpol_dpg_20_data_center_data", ... 
    "mpol_dpg_20_data_center_voting_mov_two_steps_data",...
    "mpol_dpg_20_data_center_mm_b2_rd01_data", ...
    "mpol_dpg_20_data_center_mm_b2_rd75_data", "mpol_dpg_20_data_center_mm_b2_rd90_data",...
    "mpol_dpg_20_density_based_historic_a10_data",...
    "mpol_dpg_20_density_based_dens_best_data",...
    "mpol_dpg_20_data_center_bm_a90_data");

    %"../../../projects/grl/build/mpol_dpg_20_data_center_bm_a90_data",...

%%
compare_executions(n, folder, 0, 'MPOL DPG 20 BC',...
    "pendulum_dpg.dat", "mpol_dpg_20_data_center_data",...
    "mpol_dpg_20_density_based_bm_a90_data",...
    "mpol_dpg_20_density_based_historic_dens_data",...
    "mpol_dpg_20_density_based_dens_best_data",...
    "mpol_dpg_20_data_center_bm_a90_data", "mpol_dpg_20_density_based_data");

%% MPOL DPG 26 DATA_CENTER 1
compare_executions(n, folder, 0, 'MPOL DPG 26 DATA CENTER 1',...
    "pendulum_dpg.dat", "mpol_dpg_26_data_center_mean_mov_a001_data", ...
    "mpol_dpg_26_data_center_voting_mov_data",...
    "mpol_dpg_26_data_center_data",...
    "mpol_dpg_26_data_center_mean_mov_a01_data", "mpol_dpg_26_data_center_mean_mov_a001_data",...
    "mpol_dpg_26_data_center_mean_mov_a01_data", "mpol_dpg_26_data_center_mean_mov_a10_data",...
    "mpol_dpg_26_data_center_mean_mov_a20_data",  "mpol_dpg_26_data_center_bm_a90_data",...
    "mpol_dpg_26_data_center_voting_mov_two_steps_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 0, 'MPOL DPG 26 DENSITY BASED TODOS/BC',...
    "pendulum_dpg.dat", ...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_historic_dens_data",...
    "mpol_dpg_26_density_based_dens_best_data",...
    "mpol_dpg_26_density_based_mm_a90_data", "mpol_dpg_26_density_based_historic_a10_data",...
    "mpol_dpg_26_density_based_historic_data", "mpol_dpg_26_density_based_historic_a001_data",...
    "mpol_dpg_26_density_based_bm_a90_data");
%"mpol_dpg_26_density_based_voting_mov_data",

%% MPOL DPG 26 Density based
compare_executions(n, folder, 0, 'MPOL DPG 26 DENSITY BASED TODOS/BC',...
    "mpol_dpg_26_density_based_historic_a10_data",...
    "mpol_dpg_26_density_based_historic_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 0, 'MPOL DPG 26 DENSITY BASED BC',...
    "pendulum_dpg.dat", "mpol_dpg_26_data_center_bm_a90_data",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_historic_dens_data",...
    "mpol_dpg_26_data_center_data",...
    "mpol_dpg_26_density_based_dens_best_data",...
    "mpol_dpg_26_density_based_bm_a90_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 0, 'MPOL DPG 26 DENSITY BASED BC',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_historic_dens_data",...
    "mpol_dpg_26_density_based_dens_best_data",...
    "mpol_dpg_26_density_based_bm_a90_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 2, 'MPOL DPG 26 DENSITY BASED DB vs BM',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_bm_a90_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 1, 'MPOL DPG 26 DENSITY BASED DB vs DB',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_dens_best_data");

%% MPOL DPG 26 Density based
compare_executions(n, folder, 1, 'MPOL DPG 26 DENSITY BASED DB vs HD',...
    "pendulum_dpg.dat",...
    "mpol_dpg_26_density_based_data",...
    "mpol_dpg_26_density_based_historic_dens_data");

%%
compare_executions(n, folder, 1, 'MPOL DPG 26 BC',...
    "pendulum_dpg.dat", "mpol_dpg_26_alg4steps_dens_dens_max_none_data",...
    "mpol_dpg_26_density_based_bm_a01_discretetime_data",...
    "mpol_dpg_26_density_based_bm_a90_",...
    "mpol_dpg_26_density_based_bm_a90_data",...
    "mpol_dpg_26_density_based_dens_best_data");

%%
compare_executions(n, folder, 1, 'MPOL DPG 26 BC',...
    "mpol_dpg_26_density_based_bm_a10_discretetime_",...
    "mpol_dpg_26_density_based_bm_a01_discretetime_data");

compare_executions(n, folder, 1, 'MPOL DPG 26 BC',...
    "mpol_dpg_26_density_based_bm_a01_discretetime_data",...
    "mpol_dpg_26_density_based_bm_a01_");

compare_executions(n, folder, 1, 'MPOL DPG 26 BC',...
    "mpol_dpg_26_density_based_bm_a10_discretetime_",...
    "mpol_dpg_26_density_based_bm_a01_discretetime_data",...
    "mpol_dpg_26_density_based_bm_a01_");

%%
compare_executions(n, folder, 0, 'MPOL DPG 26 density based alpha bm',...
    "pendulum_dpg.dat",...
    'mpol_dpg_26_density_based_bm_a90_data',...
    'mpol_dpg_26_density_based_bm_a01_discretetime_data');

%% MPOL DPG CARTPOLE 
compare_executions(n, folder, 2, 'MPOL DPG CARTPOLE',...
  "cart_pole_dpg_data",...  
  "cartpole_q_data");

%% MPOL DPG CARTPOLE
compare_executions(n, folder, 0, 'MPOL DPG CARTPOLE',...
    "cart_pole_dpg_data", "cartpole_mpol_dpg_26_density_based_data",...
    "cartpole_mpol_dpg_26_data_center_data",...
    "cartpole_mpol_dpg_26_data_center_voting_mov_two_steps_data",....
    "cartpole_mpol_dpg_26_data_center_mm_a90_data","cartpole_mpol_dpg_26_data_center_bm_a90_data",...
    "cartpole_mpol_dpg_26_data_center_voting_mov_data");

%% MPOL DPG CARTPOLE 
compare_executions(n, folder, 0, 'MPOL DPG CARTPOLE',...
    "cart_pole_dpg_data", "cartpole_mpol_dpg_26_density_based_voting_movdata",...
    "cartpole_mpol_dpg_26_density_based_mm_a90_data",...
    "cartpole_mpol_dpg_26_density_based_bm_a01_data",...
    "cartpole_mpol_dpg_26_data_center_voting_mov_data");
