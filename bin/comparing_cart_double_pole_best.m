clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_choosing_best/";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 20;

array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.98_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.98_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt"];
title_fig = "FINDING BEST SINGLE CART POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
    "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt",...
    "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt"];
title_fig = "FINDING BEST SINGLE CART POLE";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 1";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 2";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 3";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 4";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 5";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 6";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 7";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 8";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%

%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];
title_fig = "FINDING BEST SINGLE CART POLE 9";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval10000_gamma0.98_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval10000_gamma0.98_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval10000_gamma0.99_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval10000_gamma0.99_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.98_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.98_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt"];
title_fig = "FINDING BEST SINGLE CART POLE 10";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval10000_gamma0.98_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval10000_gamma0.98_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval10000_gamma0.99_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval10000_gamma0.99_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval4000_gamma0.98_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval4000_gamma0.98_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval4000_gamma0.99_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size256_interval4000_gamma0.99_reward_scale0.1_*txt"];
title_fig = "FINDING BEST SINGLE CART POLE  11";

ploting_executions(folder, title_fig, steps_per_second, array_runs);



%%
array_runs = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt"];
title_fig = "FINDING BEST SINGLE CART POLE 12";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

