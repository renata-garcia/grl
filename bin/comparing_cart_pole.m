clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");

%%
%Interval 10.000
%reward scale 0.1
%replay 128, batch_size 52

f = ["cart_2019_04_12_21/cartpole_mpol_ddpg_16_alg4steps*.txt",...
    "cart_pole_2019_04_14/cart_pole_mpol_ddpg_16_alg4steps_2*.txt",...
    "cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*.txt",...
    "cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128*.txt" , ...
    "cart_pole_new/cart_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64*.txt"];

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
f = ["cart_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size64*.txt" , ...
"cart_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size128*.txt" , ...
"cart_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size256*.txt" , ...
"cart_pole_replay_ddpg_tensorflow_geometric_replay_steps64_batch_size64*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_pole_new/" + f(j);
    data = readseries(fd, 3, 2, 1);
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
f = ["cart_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size128*.txt" , ...
"cart_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size256*.txt" , ...
"cart_pole_replay_ddpg_tensorflow_geometric_replay_steps128_batch_size64*.txt" , ...
"cart_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size128*.txt" , ...
"cart_pole_replay_ddpg_tensorflow_geometric_replay_steps32_batch_size256*.txt"];

size_windows = [0 0 0.75 0.75];
title_fig = "CART_POLE";
leg = [];
    
figure('units','normalized','outerposition',size_windows);
leg = [];
color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
num_alg = length(f);
h = zeros(1, num_alg);
for j=1:size(f,2)
    fd = "/home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/cart_pole_new/" + f(j);
    data = readseries(fd, 3, 2, 1);
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
