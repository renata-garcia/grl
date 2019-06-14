clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
subfolder = "cart_double_pole_cdp_tau_yamls_results/";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 20;

%%cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i
% array_runs = [subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i16*txt",...
%               subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i20*txt"];
% title_fig = "FINDING BEST SINGLE CART POLE V1";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
%%
prefix="cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i";
array_runs = [subfolder + prefix + "0*.txt",...
    subfolder + prefix + "11*.txt",...
    subfolder + prefix + "12*.txt"];
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i3*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i4*.txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i5*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i6*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i7*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i8*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i9*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i10*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i11*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i12*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i13*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i14*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i15*txt",...
%     subfolder + "cart_double_pole_cdp_tau_replay_ddpg_tensorflow_sincos_i20*txt"];
title_fig = "";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i1*.txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i2*.txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i3*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i4*.txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i5*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i6*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i7*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i8*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i9*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i10*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i11*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i12*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i13*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i14*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i15*txt",...
    subfolder + "cart_pole_replay_ddpg_tensorflow_sincos_i16*txt"];
title_fig = "FINDING BEST SINGLE CART POLE V2";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
env = "cart_double_pole";
env_abr = "cdp";
subfolder = env + "_mpols_yamls_results/";
preffix = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16";

type = "bad";
title_fig = [env, "MPOL ", type];
ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
              "_*_mean_euclidian_distance_0.1_best_a0.01_",...
              "_*_mean_euclidian_distance_0.5_density_a0.01_",...
              "_*_none_data_center_linear_order_1.0_best_a0.01_",...
              "_*_none_none_1.0_random_a1_");

type = "mid";
title_fig = [env, "MPOL ", type];
ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
              "_*_mean_euclidian_distance_0.1_best_a0.01_",...
              "_*_mean_euclidian_distance_0.5_density_a0.01_",...
              "_*_none_data_center_linear_order_1.0_best_a0.01_",...
              "_*_none_none_1.0_random_a1_");

type = "good";
title_fig = [env, "MPOL ", type];
ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
              "_*_mean_euclidian_distance_0.1_best_a0.01_",...
              "_*_mean_euclidian_distance_0.5_density_a0.01_",...
              "_*_none_data_center_linear_order_1.0_best_a0.01_",...
              "_*_none_none_1.0_random_a1_");

%%
env = "cart_double_pole";
env_abr = "cdp";
subfolder = env + "_mpols_load_yamls_results/";
preffix = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16";

type = "good_load";
title_fig = [env, "MPOL ", type];
ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
              "_j*_mean_euclidian_distance_0.1_best_a0.01_",...
              "_*_mean_euclidian_distance_0.5_density_a0.01_",...
              "_*_none_data_center_linear_order_1.0_best_a0.01_",...
              "_*_none_none_1.0_random_a1_");
%%
env = "cart_double_pole";
env_abr = "cdp";
subfolder = env + "_mpols_yamls_results/";
preffix = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16";

type = "good";
title_fig = [env, "MPOL ", type];

subfolder2 = "cart_double_pole_mpols_load_yamls_results/";
preffix2 = "cart_double_pole_cdp_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load";

array_runs = [subfolder2 + preffix2 + "_j*_mean_euclidian_distance_0.1_best_a0.01_*txt",...
              subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
              subfolder2 + preffix2 + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
              subfolder2 + preffix2 + "_*_none_none_1.0_random_a1_*txt",...          
              subfolder + preffix + type + "_*_mean_euclidian_distance_0.1_best_a0.01_*txt",...
              subfolder + preffix + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
              subfolder + preffix + type + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
              subfolder + preffix + type + "_*_none_none_1.0_random_a1_*txt"];
          
%               "cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*.txt",...
%               subfolder + "cart_pole_cart_pole_mpol_replay_ddpg_tensorflow_sincos_16good_*_density_euclidian_distance_0.01_best_a0.01_*.txt",...
%               "cart_pole_yamls_results/cart_pole_cart_pole_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.1_best_a0.01_*.txt",...
%               "cart_pole_yamls_results/cart_pole_cart_pole_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.5_data_center_a0.01_*.txt",...
%               "cart_pole_yamls_results/cart_pole_cart_pole_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%               "cart_pole_yamls_results/cart_pole_cart_pole_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_data_center_linear_order_1.0_best_a0.01_*.txt",...
%               "cart_pole_yamls_results/cart_pole_cart_pole_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_density_0.5_data_center_a0.01_*.txt",...
%               "cart_pole_yamls_results/cart_pole_cart_pole_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_density_0.5_density_a0.01_*.txt",...
%               "cart_pole_yamls_results/cart_pole_cart_pole_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_density_1.0_best_a0.01_*.txt"];

title_fig = "MPOL CART POLE GOOD";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MPOL DPG CART DOUBLE POLE 
compare_executions(n, folder, 2, 909, 'MPOL DDPG CART DOUBLE POLE',...
  "cart_double_pole_mpol_1_replay_ddpg_tensorflow_");

%%
array_runs = ["cart_double_pole/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval512_gamma0.98_reward_scale0.01_*.txt",...
    "cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt"];
title_fig = "TRYING MPOL CART DOUBLE POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = ["cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt"];
title_fig = "TRYING MPOL CART DOUBLE POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt"];
title_fig = "TRYING MPOL CART DOUBLE POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt"];
title_fig = "TRYING MPOL CART DOUBLE POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "TRYING MPOL CART DOUBLE POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%%
array_runs = ["cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt"];
title_fig = "TRYING MPOL CART DOUBLE POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt"];
title_fig = "TRYING MPOL CART DOUBLE POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval512_gamma0.99_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval64_gamma0.99_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval2048_gamma0.98_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval64_gamma0.98_reward_scale0.01_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval2048_gamma0.98_reward_scale0.01_*.txt",...
    "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval512_gamma0.99_reward_scale0.01_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval512_gamma0.98_reward_scale0.01_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval64_gamma0.99_reward_scale0.1_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval2048_gamma0.99_reward_scale0.01_*.txt"];

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval64_gamma0.98_reward_scale0.1_*.txt"];


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval2048_gamma0.98_reward_scale0.01_*.txt"];


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval512_gamma0.99_reward_scale0.1_*.txt"];


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt"];


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval512_gamma0.98_reward_scale0.1_*.txt"];


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval10000_gamma0.98_reward_scale0.01_*.txt"];


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval2048_gamma0.99_reward_scale0.1_*.txt"];


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval64_gamma0.99_reward_scale0.1_*.txt"];


