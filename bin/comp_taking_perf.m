clc;
clear;
close all;

% % 
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");

steps_counted = 10;
printing = 0;

for 
env = "cart_pole"; env_abr = "cp";
% env = "cart_double_pole"; env_abr = "cdp";
% env = "pendulum"; env_abr = "pd";

if (contains(env,"cart"))
    steps_per_second = 20;
elseif (contains(env,"pendulum"))
    steps_per_second = 33;
else
    disp("NONE NONE");
end

type = "good";
means = take_mean_mpol(folder, type, "", env, env_abr, printing, steps_per_second, steps_counted);
means = take_mean_mpol(folder, type, "_load", env, env_abr, printing, steps_per_second, steps_counted);

type = "mid";
means = take_mean_mpol(folder, type, "", env, env_abr, printing, steps_per_second, steps_counted);
means = take_mean_mpol(folder, type, "_load", env, env_abr, printing, steps_per_second, steps_counted);

type = "bad";
means = take_mean_mpol(folder, type, "", env, env_abr, printing, steps_per_second, steps_counted);
means = take_mean_mpol(folder, type, "_load", env, env_abr, printing, steps_per_second, steps_counted);

function means = take_mean_mpol(folder, type, load, env, env_abr, printing, steps_per_second, steps_counted)
    subfolder = env + "_mpols" + load + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + load;

    array_runs = [subfolder + preffix + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                  subfolder + preffix + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                  subfolder + preffix + "_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt",...
                  subfolder + preffix + "_*_mean_euclidian_distance_0.1_best_a0.01_*txt",...
                  subfolder + preffix + "_*_none_none_1.0_data_center_a1.0_*txt",...
                  subfolder + preffix + "_*_none_none_1.0_density_a1.0_*txt",...
                  subfolder + preffix + "_*_none_none_1.0_mean_a1.0_*txt",...
                  subfolder + preffix + "_*_none_density_0.5_data_center_a0.01_*txt",...
                  subfolder + preffix + "_*_none_none_1.0_random_a1_*txt",...
                  subfolder + preffix + "_*_density_euclidian_distance_0.01_best_a0.01_*txt",...
                  subfolder + preffix + "_*_none_density_0.5_density_a0.01_*txt",...
                  subfolder + preffix + "_*_none_density_1.0_best_a0.01_*txt"];

    fd = folder + array_runs(1);
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_d] = avgseries(readseries(fd, 3, 2, steps_per_second));

    fprintf('i: %d, ',length(mean_d)-steps_counted+1);
    fprintf('length: %d\n',length(mean_d));

    means = zeros(length(array_runs), 1);
    for j=1:length(array_runs)
        fd = folder + array_runs(j);
        if (printing)
            disp(fd);
        end
        [t, mean_d, ~, std_d] = avgseries(readseries(fd, 3, 2, steps_per_second));
        means(j) = mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d)));
        fprintf("%.2f \n", means(j));
    end
end
