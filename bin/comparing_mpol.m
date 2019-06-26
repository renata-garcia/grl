clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");

%%
env = "pendulum";
env_abr = "pd";
env_title = "PENDULUM";
steps_per_second = 33;
old_name = 1;

type = "GOOD";
p = [1, 2, 3, 8, 9, 10, 13, 15, 16, 17, 19, 20, 21, 25, 29, 32];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

type = "MID";
p = [1, 3, 5, 7, 8, 9, 13, 15, 17, 19, 20, 21, 23, 25, 28, 32];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

type = "BAD";
p = [1, 3, 5, 7, 8, 9, 13, 15, 19, 23, 25, 26, 27, 28, 31, 32];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

p = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];
plot_single_all(folder, steps_per_second, env, env_abr, env_title, p, old_name);

type = "bad";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "good";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)
%%
type = "good";
plot_mpol_load_best_type(folder, steps_per_second, env, env_abr, env_title, type)
%%
type = "mid";
plot_mpol_load_best_type(folder, steps_per_second, env, env_abr, env_title, type)
%%
type = "bad";
plot_mpol_load_best_type(folder, steps_per_second, env, env_abr, env_title, type)

%%
env = "cart_pole";
env_abr = "cp";
env_title = "CART POLE";
steps_per_second = 20;
old_name = 1;

type = "GOOD";
p = [1, 2, 3, 8, 9, 10, 13, 15, 16, 17, 19, 20, 21, 25, 29, 32];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

type = "MID";
p = [1, 3, 5, 7, 8, 9, 13, 15, 17, 19, 20, 21, 23, 25, 28, 32];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

type = "BAD";
p = [1, 3, 5, 7, 8, 9, 13, 15, 19, 23, 25, 26, 27, 28, 31, 32];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

p = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];
plot_single_all(folder, steps_per_second, env, env_abr, env_title, p, old_name);

type = "bad";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "good";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "good";
plot_mpol_load_best_type(folder, steps_per_second, env, env_abr, env_title, type)
%%
type = "mid";
plot_mpol_load_best_type(folder, steps_per_second, env, env_abr, env_title, type)
%%
type = "bad";
plot_mpol_load_best_type(folder, steps_per_second, env, env_abr, env_title, type)

%%
env = "cart_double_pole";
env_abr = "cdp";
env_title = "CART DOUBLE POLE";
steps_per_second = 20;
old_name = 0;

type = "GOOD";
p = [0, 1, 2, 3, 6, 10, 11, 12, 15, 17, 22, 23, 24, 25, 30, 31];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

type = "MID";
p = [0, 2, 3, 6, 8, 10, 11, 12, 14, 17, 20, 22, 25, 28, 30, 31];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

type = "BAD";
p = [0, 2, 3, 4, 5, 6, 7, 8, 14, 17, 20, 22, 28, 29, 30, 31];
plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name);

p = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];
plot_single_all(folder, steps_per_second, env, env_abr, env_title, p, old_name);

type = "bad";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "good";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

%%
type = "good";
plot_mpol_load_best_type(folder, steps_per_second, env, env_abr, env_title, type)

%%
type = "good";
plot_mpol_all_type(folder, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_all_type(folder, steps_per_second, env, env_abr, env_title, type)

type = "bad";
plot_mpol_all_type(folder, steps_per_second, env, env_abr, env_title, type)

%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %%
%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %%
%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %%
function plot_single_type(folder, steps_per_second, env, env_abr, env_title, type, p, old_name)
    subfolder = env + "_yamls_results/";
    if (old_name == 1)
        preffix = env + "_" + "replay_ddpg_tensorflow_sincos_i";
    else
        preffix = env + "_" + env_abr + "_tau_replay_ddpg_tensorflow_sincos_i";
    end
    array_runs = [subfolder + preffix + p(1) + "_j*.txt",...
        subfolder + preffix + p(2) + "_j*.txt",...
        subfolder + preffix + p(3) + "_j*txt",...
        subfolder + preffix + p(4) + "_j*.txt",...
        subfolder + preffix + p(5) + "_j*txt",...
        subfolder + preffix + p(6) + "_j*txt",...
        subfolder + preffix + p(7) + "_j*txt",...
        subfolder + preffix + p(8) + "_j*txt",...
        subfolder + preffix + p(9) + "_j*txt",...
        subfolder + preffix + p(10) + "_j*txt",...
        subfolder + preffix + p(11) + "_j*txt",...
        subfolder + preffix + p(12) + "_j*txt",...
        subfolder + preffix + p(13) + "_j*txt",...
        subfolder + preffix + p(14) + "_j*txt",...
        subfolder + preffix + p(15) + "_j*txt",...
        subfolder + preffix + p(16) + "_j*txt"];
    title_fig = "SINGLE " + env_title + " " + type;
    ploting_executions(folder, title_fig, steps_per_second, array_runs);
end

function plot_single_all(folder, steps_per_second, env, env_abr, env_title, p, old_name)
    subfolder = env + "_yamls_results/";
    if (old_name == 1)
        preffix = env + "_" + "replay_ddpg_tensorflow_sincos_i";
    else
        preffix = env + "_" + env_abr + "_tau_replay_ddpg_tensorflow_sincos_i";
    end
    array_runs = [subfolder + preffix + p(1) + "_j*.txt",...
        subfolder + preffix + p(2) + "_j*.txt",...
        subfolder + preffix + p(3) + "_j*txt",...
        subfolder + preffix + p(4) + "_j*.txt",...
        subfolder + preffix + p(5) + "_j*txt",...
        subfolder + preffix + p(6) + "_j*txt",...
        subfolder + preffix + p(7) + "_j*txt",...
        subfolder + preffix + p(8) + "_j*txt",...
        subfolder + preffix + p(9) + "_j*txt",...
        subfolder + preffix + p(10) + "_j*txt",...
        subfolder + preffix + p(11) + "_j*txt",...
        subfolder + preffix + p(12) + "_j*txt",...
        subfolder + preffix + p(13) + "_j*txt",...
        subfolder + preffix + p(14) + "_j*txt",...
        subfolder + preffix + p(15) + "_j*txt",...
        subfolder + preffix + p(16) + "_j*txt",...
        subfolder + preffix + p(17) + "_j*.txt",...
        subfolder + preffix + p(18) + "_j*.txt",...
        subfolder + preffix + p(19) + "_j*txt",...
        subfolder + preffix + p(20) + "_j*.txt",...
        subfolder + preffix + p(21) + "_j*txt",...
        subfolder + preffix + p(22) + "_j*txt",...
        subfolder + preffix + p(23) + "_j*txt",...
        subfolder + preffix + p(24) + "_j*txt",...
        subfolder + preffix + p(25) + "_j*txt",...
        subfolder + preffix + p(26) + "_j*txt",...
        subfolder + preffix + p(27) + "_j*txt",...
        subfolder + preffix + p(28) + "_j*txt",...
        subfolder + preffix + p(29) + "_j*txt",...
        subfolder + preffix + p(30) + "_j*txt",...
        subfolder + preffix + p(31) + "_j*txt",...
        subfolder + preffix + p(32) + "_j*txt"];
    title_fig = "SINGLE " + env_title + " ALL";
    ploting_executions(folder, title_fig, steps_per_second, array_runs);
end

function plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16";
 
    title_fig = [env_title, " MPOL ", type];
    ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
                  "_*_mean_euclidian_distance_0.1_best_a0.01_",...
                  "_*_mean_euclidian_distance_0.5_density_a0.01_",...
                  "_*_none_data_center_linear_order_1.0_best_a0.01_",...
                  "_*_none_none_1.0_random_a1_");
end


function plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16";
 
    title_fig = [env_title, " MPOL ", type];
    ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
                  "_*_mean_euclidian_distance_0.5_data_center_a0.01_",...
                  "_*_mean_euclidian_distance_0.5_density_a0.01_",...
                  "_*_mean_euclidian_distance_0.1_best_a0.01_",...
                  "_*_none_data_center_linear_order_1.0_best_a0.01_",...
                  "_*_none_none_1.0_data_center_a1.0_",...
                  "_*_none_none_1.0_random_a1_");
    ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
                  "_*_none_none_1.0_density_a1.0_",...
                  "_*_none_none_1.0_mean_a1.0_",...
                  "_*_none_density_0.5_data_center_a0.01_",...
                  "_*_none_none_1.0_random_a1_");
%                   "_*_density_euclidian_distance_0.01_best_a0.01_",...
%                   "_*_none_density_0.5_density_a0.01_",...
%                   "_*_none_density_1.0_best_a0.01_",...
end

function plot_mpol_load_best_type(folder, steps_per_second, env, env_abr, env_title, type)
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";

    subfolder2 = env + "_mpols_load_yamls_results/";
    preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";

    array_runs = [subfolder2 + preffix2 + "_j*_mean_euclidian_distance_0.1_best_a0.01_*txt",...
                  subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                  subfolder2 + preffix2 + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_random_a1_*txt",...          
                  subfolder + preffix + type + "_*_mean_euclidian_distance_0.1_best_a0.01_*txt",...
                  subfolder + preffix + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                  subfolder + preffix + type + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_random_a1_*txt"];

    title_fig = [env_title, " MPOL ", type];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);

end

