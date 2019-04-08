clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");

%%
f = ["cart_double_pole/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval512_gamma0.98_reward_scale0.01_*.txt",...
    "cart_double_pole_new/cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/" + f(j);
    data = readseries(fd, 3, 2, 33);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 33);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.1_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.01_*.txt" , ...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole_new/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

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

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

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

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128_interval64_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

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

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval64_gamma0.98_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size52_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval2048_gamma0.98_reward_scale0.01_*.txt",...
    "cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval512_gamma0.99_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size128_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval512_gamma0.98_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size256_interval64_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval2048_gamma0.99_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');

%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval64_gamma0.98_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps26_batch_size52_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval2048_gamma0.98_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval512_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size128_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval10000_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval10000_gamma0.99_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval2048_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval512_gamma0.98_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size256_interval64_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval10000_gamma0.98_reward_scale0.01_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval10000_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval10000_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval10000_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval2048_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval2048_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval2048_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval2048_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');


%%
f = ["cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval512_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval512_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval512_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval512_gamma0.99_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval64_gamma0.98_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval64_gamma0.98_reward_scale0.1_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval64_gamma0.99_reward_scale0.01_*.txt",...
"cart_double_pole_replay_ddpg_tensorflow_geometric_replay_steps52_batch_size52_interval64_gamma0.99_reward_scale0.1_*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_double_pole/" + f(j);
    data = readseries(fd, 3, 1, 1);
    [t, mean_d, ~, std_d] = avgseries(data);
    %errstd_d = std_d/sqrt(n);
    maximum = max(mean_d);
    n_color = color(1 + rem(j, length(color)));
    h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
    leg = [leg, strcat(f(j), ':... ', num2str(maximum))];
    hold on;
end
grid;
title([title_fig, ' (int val 95)']);
xlabel('step');
ylabel('reward');
legend(h, leg,'Location','SouthEast');
