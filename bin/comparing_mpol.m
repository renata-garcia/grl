% TODO VERIFICANDO QUANTIDADE DE ARQUIVOS
% TODO VERIFICANDO FINALIZAÇÃO DE ARQUIVOS
clc;
clear;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");

%% comparações
plot_mpol_load_compare2(folder, "good");

%%
env = "pendulum";
env_abr = "pd";
env_title = "PENDULUM";
steps_per_second = 33;
old_name = 1;

% % plot_single_type OK ALL 10
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

% % plot_mpol_all_type OK ALL 12 OF J[0-9]
% pendulum_mpols_yamls_results
% $ ~/projects/grl_sh/runs_32_policy_count.sh pendulum_pd_tau_mpol txt noprint init0 mpol all

type = "good";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "bad";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)

% % plot_mpol_load_all_type OK ALL 12 OF J[0-9]
% pendulum_mpols_load_yamls_results
% $ ~/projects/grl_sh/runs_32_policy_count.sh pendulum_pd_tau_mpol txt noprint init0 load all

type = "good";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)

type = "bad";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)

% %
% type = "good";
% plot_mpol_load_compare(folder, steps_per_second, env, env_abr, env_title, type)
% %
% type = "mid";
% plot_mpol_load_compare(folder, steps_per_second, env, env_abr, env_title, type)
% 
% type = "bad";
% plot_mpol_load_compare(folder, steps_per_second, env, env_abr, env_title, type)

%%
env = "cart_pole";
env_abr = "cp";
env_title = "CART POLE";
steps_per_second = 20;
old_name = 1;

% plot_single_type OK ALL 10
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

% % plot_mpol_all_type OK ALL 12 OF J[0-9]
% cart_pole_mpols_yamls_results
% $ ~/projects/grl_sh/runs_32_policy_count.sh cart_pole_cp_tau_mpol txt noprint init0 mpol all

type = "bad";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "good";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

% % plot_mpol_all_type
type = "good";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)
%
type = "mid";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)
%
type = "bad";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)

% % plot_mpol_load_all_type OK ALL 12 OF J[0-9]
% cart_pole_mpols_load_yamls_results
% ~/projects/grl_sh/runs_32_policy_count.sh cart_pole_cp_tau_mpol txt noprint init0 load all 

type = "good";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)

type = "bad";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)

%%
env = "cart_double_pole";
env_abr = "cdp";
env_title = "CART DOUBLE POLE";
steps_per_second = 20;
old_name = 0;

% % plot_single_type OK ALL 10
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

% % plot_mpol_all_type OK ALL 12 OF J[0-9]
type = "bad";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "good";
plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)

% % plot_mpol_all_type OK ALL 12 OF J[0-9]
% ~/projects/grl_sh/runs_32_policy_count.sh cart_double_pole_cdp_tau_mpol txt noprint init0 mpol all
type = "good";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)

type = "bad";
plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)

% % plot_mpol_load_all_type OK ALL 12 OF J[0-9]
% cart_double_pole_mpols_load_yamls_results
% $ ~/projects/grl_sh/runs_32_policy_count.sh cart_double_pole_cdp_tau_mpol txt noprint init0 load all

type = "good";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)

type = "mid";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)

type = "bad";
plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)


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
    array_runs = [
        subfolder + preffix +  p(1) + "_j*txt",...
        subfolder + preffix +  p(2) + "_j*txt",...
        subfolder + preffix +  p(3) + "_j*txt",...
        subfolder + preffix +  p(4) + "_j*txt",...
        subfolder + preffix +  p(5) + "_j*txt",...
        subfolder + preffix +  p(6) + "_j*txt",...
        subfolder + preffix +  p(7) + "_j*txt",...
        subfolder + preffix +  p(8) + "_j*txt",...
        subfolder + preffix +  p(9) + "_j*txt",...
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
    array_runs = [
        subfolder + preffix +  p(1) + "_j*txt",...
        subfolder + preffix +  p(2) + "_j*txt",...
        subfolder + preffix +  p(3) + "_j*txt",...
        subfolder + preffix +  p(4) + "_j*txt",...
        subfolder + preffix +  p(5) + "_j*txt",...
        subfolder + preffix +  p(6) + "_j*txt",...
        subfolder + preffix +  p(7) + "_j*txt",...
        subfolder + preffix +  p(8) + "_j*txt",...
        subfolder + preffix +  p(9) + "_j*txt",...
        subfolder + preffix + p(10) + "_j*txt",...
        subfolder + preffix + p(11) + "_j*txt",...
        subfolder + preffix + p(12) + "_j*txt",...
        subfolder + preffix + p(13) + "_j*txt",...
        subfolder + preffix + p(14) + "_j*txt",...
        subfolder + preffix + p(15) + "_j*txt",...
        subfolder + preffix + p(16) + "_j*txt",...
        subfolder + preffix + p(17) + "_j*txt",...
        subfolder + preffix + p(18) + "_j*txt",...
        subfolder + preffix + p(19) + "_j*txt",...
        subfolder + preffix + p(20) + "_j*txt",...
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
    title_fig = strcat("SINGLE ALL", env_title, " ALL");
    ploting_executions(folder, title_fig, steps_per_second, array_runs);
end

function plot_mpol_best_type(folder, n, steps_per_second, env, env_abr, env_title, type)
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16";
 
    title_fig = [env_title, " MPOL CHOOSEN ", type];
    ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
                  "_*_mean_euclidian_distance_0.1_best_a0.01_",...
                  "_*_mean_euclidian_distance_0.5_density_a0.01_",...
                  "_*_none_data_center_linear_order_1.0_best_a0.01_",...
                  "_*_none_none_1.0_random_a1_");
end

function plot_mpol_all_type(folder, n, steps_per_second, env, env_abr, env_title, type)
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16";
 
    title_fig = strcat(env_title, " MPOL ALL", type);
    ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
                  "_*_mean_euclidian_distance_0.5_density_a0.01_",...
                  "_*_mean_euclidian_distance_0.5_data_center_a0.01_",...
                  "_*_none_data_center_linear_order_1.0_best_a0.01_",...
                  "_*_mean_euclidian_distance_0.1_best_a0.01_",...
                  "_*_none_none_1.0_data_center_a1.0_",...
                  "_*_none_none_1.0_density_a1.0_",...
                  "_*_none_none_1.0_mean_a1.0_",...
                  "_*_none_density_0.5_data_center_a0.01_",...
                  "_*_none_none_1.0_random_a1_",...
                  "_*_density_euclidian_distance_0.01_best_a0.01_",...
                  "_*_none_density_0.5_density_a0.01_",...
                  "_*_none_density_1.0_best_a0.01_");
    title_fig = strcat(env_title, " MPOL THE BEST", type);
    ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
                  "_*_mean_euclidian_distance_0.5_density_a0.01_",...
                  "_*_mean_euclidian_distance_0.5_data_center_a0.01_",...
                  "_*_none_data_center_linear_order_1.0_best_a0.01_",...
                  "_*_mean_euclidian_distance_0.1_best_a0.01_",...
                  "_*_none_none_1.0_data_center_a1.0_",...
                  "_*_none_none_1.0_random_a1_");
    title_fig = strcat(env_title, " MPOL OTHERS", type);
    ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig,...
                  "_*_none_none_1.0_density_a1.0_",...
                  "_*_none_none_1.0_mean_a1.0_",...
                  "_*_none_density_0.5_data_center_a0.01_",...
                  "_*_none_none_1.0_random_a1_",...
                  "_*_density_euclidian_distance_0.01_best_a0.01_",...
                  "_*_none_density_0.5_density_a0.01_",...
                  "_*_none_density_1.0_best_a0.01_");
end

function plot_mpol_load_all_type(folder, steps_per_second, env, env_abr, env_title, type)
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";

    subfolder2 = env + "_mpols_load_yamls_results/";
    preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";

%     array_runs = [subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
%                   subfolder2 + preffix2 + "_*_none_none_1.0_random_a1_*txt",...          
%                   subfolder + preffix + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
%                   subfolder + preffix + type + "_*_none_none_1.0_random_a1_*txt"];
              
              
    title_fig = strcat(env_title, " MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_j*_mean_euclidian_distance_0.1_best_a0.01_*txt",...
                  subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                  subfolder2 + preffix2 + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                  subfolder + preffix + type + "_*_mean_euclidian_distance_0.1_best_a0.01_*txt",...
                  subfolder + preffix + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                  subfolder + preffix + type + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
              
    %1
    title_fig = strcat(env_title, " RDZ 1.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                  subfolder + preffix + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %2
    title_fig = strcat(env_title, " RDZ 2.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                  subfolder + preffix + type + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %3
    title_fig = strcat(env_title, " RDZ 3.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt",...
                  subfolder + preffix + type + "_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %4
    title_fig = strcat(env_title, " RDZ 4.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.1_best_a0.01_*txt",...
                  subfolder + preffix + type + "_*_mean_euclidian_distance_0.1_best_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %5
    title_fig = strcat(env_title, " RDZ 5.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_none_none_1.0_data_center_a1.0_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_data_center_a1.0_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %6
    title_fig = strcat(env_title, " RDZ 6.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_none_none_1.0_density_a1.0_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_density_a1.0_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %7
    title_fig = strcat(env_title, " RDZ 7.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_none_none_1.0_mean_a1.0_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_mean_a1.0_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %8
    title_fig = strcat(env_title, " RDZ 8.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_none_density_0.5_data_center_a0.01_*txt",...
                  subfolder + preffix + type + "_*_none_density_0.5_data_center_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %9
    title_fig = strcat(env_title, " RDZ 9.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_none_none_1.0_random_a1_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_random_a1_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %10
    title_fig = strcat(env_title, " RDZ 10.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_density_euclidian_distance_0.01_best_a0.01_*txt",...
                  subfolder + preffix + type + "_*_density_euclidian_distance_0.01_best_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %11
    title_fig = strcat(env_title, " RDZ 11.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_none_density_0.5_density_a0.01_*txt",...
                  subfolder + preffix + type + "_*_none_density_0.5_density_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);
    
    %12
    title_fig = strcat(env_title, " RDZ 12.12 MPOL W.LOAD", type);
    array_runs = [subfolder2 + preffix2 + "_*_none_density_1.0_best_a0.01_*txt",...
                  subfolder + preffix + type + "_*_none_density_1.0_best_a0.01_*txt"];

    ploting_executions(folder, title_fig, steps_per_second, array_runs);

end

function plot_mpol_load_compare(folder, type)
%     fig = figure('units','normalized','outerposition', [0 0 0.4 0.6]);
    fig = figure('units','normalized','outerposition', [0 0 1 1]);
    title_fig = "";
    x = 3;
    y = 4;
    
    env = "pendulum";
    env_abr = "pd";
    env_title = "PENDULUM";
    steps_per_second = 33;
    
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";

    subfolder2 = env + "_mpols_load_yamls_results/";
    preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_density_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 1, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_density_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 2, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 3, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 4, array_runs);
    
    env = "cart_pole";
    env_abr = "cp";
    env_title = "CART POLE";
    steps_per_second = 20;
    
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";

    subfolder2 = env + "_mpols_load_yamls_results/";
    preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_density_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 5, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_density_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 6, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 7, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 8, array_runs);

    env = "cart_double_pole";
    env_abr = "cdp";
    env_title = "CART DOUBLE POLE";
    steps_per_second = 20;
    old_name = 0;

    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";

    subfolder2 = env + "_mpols_load_yamls_results/";
    preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_density_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 9, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_density_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 10, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 11, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 12, array_runs);
   
%     hFig    = gcf;
%     hAxes   = findobj(allchild(hFig), 'flat', 'Type', 'axes');
%     hTempFig = figure;
%     for i=1:4
%         hAxRef(i)=subplot(2,2,5-i);
%     end % create reference positions
%     set(hAxes,{'position'},{hAxRef.Position}.')
%     delete(hTempFig);
%     axPosition = hAxes(1).Position;
%     set(hAxes(1), 'Position', [axPosition(1) axPosition(2) axPosition(3)-0.15 axPosition(4)]);
%     axPosition = hAxes(2).Position;
%     set(hAxes(2), 'Position', [axPosition(1) axPosition(2) axPosition(3)-0.15 axPosition(4)]);

    title_fig = strcat("CMP_LEARNED_VS_LEARNING_", type);
    print(fig, strcat("figs/plots_", title_fig,".png"),'-dpng');
end

function plot_mpol_load_compare2(folder, type)
    fig = figure('units','normalized','outerposition', [0 0 0.5 1]);
% %     fig = figure('units','normalized','outerposition', [0 0 1 1]);
    x = 3;
    y = 2;
    
    env = "pendulum";
    env_abr = "pd";
    env_title = "PENDULUM";
    steps_per_second = 33;
    title_fig = env_title;
    
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";

    subfolder2 = env + "_mpols_load_yamls_results/";
    preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_density_a1.0_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 1, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_density_a1.0_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 2, array_runs);
    
    env = "cart_pole";
    env_abr = "cp";
    env_title = "CART POLE";
    steps_per_second = 20;
    title_fig = env_title;
    
    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";

    subfolder2 = env + "_mpols_load_yamls_results/";
    preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_density_a1.0_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 3, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_density_a1.0_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 4, array_runs);
    
    env = "cart_double_pole";
    env_abr = "cdp";
    env_title = "CART DOUBLE POLE";
    steps_per_second = 20;
    old_name = 0;
    title_fig = env_title;

    subfolder = env + "_mpols" + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";

    subfolder2 = env + "_mpols_load_yamls_results/";
    preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_density_a1.0_*txt",...
                  subfolder2 + preffix2 + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 5, array_runs);
    
    array_runs = ["replay_ddpg_tensorflow_sincos_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_density_a1.0_*txt",...
                  subfolder + preffix + type + "_*_none_none_1.0_data_center_a1.0_*txt"];

    executions_subploting(folder, title_fig, steps_per_second, x, y, 6, array_runs);
    
   
%     hFig    = gcf;
%     hAxes   = findobj(allchild(hFig), 'flat', 'Type', 'axes');
%     hTempFig = figure;
%     for i=1:4
%         hAxRef(i)=subplot(2,2,5-i);
%     end % create reference positions
%     set(hAxes,{'position'},{hAxRef.Position}.')
%     delete(hTempFig);
%     axPosition = hAxes(1).Position;
%     set(hAxes(1), 'Position', [axPosition(1) axPosition(2) axPosition(3)-0.15 axPosition(4)]);
%     axPosition = hAxes(2).Position;
%     set(hAxes(2), 'Position', [axPosition(1) axPosition(2) axPosition(3)-0.15 axPosition(4)]);

    title_fig = strcat("CMP_LEARNED_VS_LEARNING_", type);
    print(fig, strcat("figs/plots_", title_fig,".png"),'-dpng');
end
