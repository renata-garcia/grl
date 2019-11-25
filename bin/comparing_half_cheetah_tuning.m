clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/half_cheetah_tuning/";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 100;
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

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.85_reward_scale1.0_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale1.0_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10000_gamma0.75_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10000_gamma0.85_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10000_gamma0.9_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10000_gamma0.9_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval100_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval10_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval100_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval10_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval100_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval10_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval100_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval10_gamma0.99_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval100_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval10000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);


%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale0.01_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"half_cheetah_hc_ddpg_replay_steps256_batch_size128_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps256_batch_size64_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size64_interval1000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval1000_gamma0.99_reward_scale0.01_sigma[1]*txt",...
"half_cheetah_hc_ddpg_replay_steps512_batch_size128_interval1000_gamma0.99_reward_scale0.1_sigma[1]*txt"];

title_fig = "FINDING BEST SINGLE HC";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
clc;
steps_counted = 10;
printing = 1;

folder_old = folder;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/half_cheetah_mpols_yamls_results/";

array_runs = [
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16good_j*_none_none_1.0_data_center_a1.0_-*.txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16good_j*_none_none_1.0_density_a1.0_-*.txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16good_j*_data_center_euclidian_distance_0.25_data_center_a0.01_-*.txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16good_j*_none_data_center_linear_order_0.25_data_center_a0.01_-*.txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16good_j*_mean_euclidian_distance_0.25_density_a0.01_-*txt"];

mean_hc = zeros(60,length(array_runs));
for j=1:length(array_runs)
    fd = folder + array_runs(j);
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_e] = avgseries(readseries(fd, 3, 2, steps_per_second));
    data_no_limiar = readseries(fd, 3, 2, steps_per_second);
    disp(length(data_no_limiar));
    mean_hc(:, j) = mean_d;
    disp(mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d))));
    disp(mean(std_e(length(std_e)-steps_counted+1:length(std_e))));
end

for i=1:length(array_runs)
    for j=(i+1):length(array_runs)
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.01,'tail','both');
        display(['H 99%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);
        
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.05,'tail','both');
        display(['H 95%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
        
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.10,'tail','both');
        display(['H 90%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
    end
end


folder = folder_old;


%%
clc;
steps_counted = 10;
printing = 1;

folder_old = folder;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/half_cheetah_mpols_yamls_results/";

array_runs = [
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16mid_j1_none_none_1.0_data_center_a1.0_-*txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16mid_j1_none_none_1.0_density_a1.0_-*txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16mid_j1_data_center_euclidian_distance_0.25_data_center_a0.01_-*txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16mid_j1_none_data_center_linear_order_0.25_data_center_a0.01_-*txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16mid_j0_mean_euclidian_distance_0.25_density_a0.01_-*txt"];

mean_hc = zeros(60,length(array_runs));
for j=1:length(array_runs)
    fd = folder + array_runs(j);
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_e] = avgseries(readseries(fd, 3, 2, steps_per_second));
    data_no_limiar = readseries(fd, 3, 2, steps_per_second);
    disp(length(data_no_limiar));
    mean_hc(:, j) = mean_d;
    disp(mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d))));
    disp(mean(std_e(length(std_e)-steps_counted+1:length(std_e))));
end

for i=1:length(array_runs)
    for j=(i+1):length(array_runs)
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.01,'tail','both');
        display(['H 99%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);
        
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.05,'tail','both');
        display(['H 95%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
        
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.10,'tail','both');
        display(['H 90%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
    end
end


folder = folder_old;

%%
clc;
steps_counted = 10;
printing = 1;

folder_old = folder;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/half_cheetah_mpols_yamls_results/";

array_runs = [
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16bad_j1_none_none_1.0_data_center_a1.0_-*txt",...
    "half_cheetah_tau_replay_ddpg_tensorflow_sincos16bad_j1_data_center_euclidian_distance_0.25_data_center_a0.01_-*txt"];

mean_hc = zeros(60,length(array_runs));
for j=1:length(array_runs)
    fd = folder + array_runs(j);
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_e] = avgseries(readseries(fd, 3, 2, steps_per_second));
    data_no_limiar = readseries(fd, 3, 2, steps_per_second);
    disp(length(data_no_limiar));
    mean_hc(:, j) = mean_d;
    disp(mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d))));
    disp(mean(std_e(length(std_e)-steps_counted+1:length(std_e))));
end

for i=1:length(array_runs)
    for j=(i+1):length(array_runs)
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.01,'tail','both');
        display(['H 99%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);
        
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.05,'tail','both');
        display(['H 95%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
        
        [hipotese1,pvalue] = ttest(mean_hc(:,i),mean_hc(:,j),'alpha',0.10,'tail','both');
        display(['H 90%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
    end
end

folder = folder_old;