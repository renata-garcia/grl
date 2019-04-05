clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");

%%
f = ["cart_pole_replay_ddpg_tensorflow_*.txt"];

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
