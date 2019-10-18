clc;
clear;
close all;

% % COUNT MEAN (LEAST 10) TO USE IN ORDERING GOO, MID AND BAD

steps_counted = 20;
printing = 1;
% env = "cart_pole";
% env = "cart_double_pole_cdp_tau";
env = "cart_double_pole"; env_abr = "cdp_";
env = "leosim"; env_abr = "_tau";
env = "pinball"; env_abr = "";
env = "walker"; env_abr = "";
env = "compass_walker"; env_abr = "cw_";
env = "cart_pole"; env_abr = "cp_";
env = "pendulum"; env_abr = "pd_";
env = "half_cheetah"; env_abr = "wc_";
alg = "";
alg = "_dpg";% env_abr = "";
alg = "_ac_tc";
folder = "/home/renatargo/projects/grl/build/";
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+ alg + "_yamls_results/";
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/walker" + alg + "_yamls_results/";
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_mpols" +alg + "_load_yamls_results/";
folder = "~/grl_results/leosim_mpols_yamls_results/";
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_yamls_results/";
addpath("~/Dropbox/phd_grl_results/matlab");
file = "cart_pole_cp_tau_ac_tc16good_load_*_none_none_1.0_random_persistent_a1_";
file = "leosim_ddpg";
file = env + "_" + env_abr + "tau" + alg + "_i";
file = env + "_" + "replay_ddpg_tensorflow_sincos_i";
file = env + "_" + "tau_replay_ddpg_tensorflow_sincos_i";

if (contains(env,"cart") || contains(env,"pinball"))
    steps_per_second = 20;
elseif (contains(env,"walker"))
    steps_per_second = 5;
elseif (contains(env,"pendulum"))
    steps_per_second = 33;
elseif (contains(env,"leosim"))
    steps_per_second = 30;
elseif (contains(env,"half_cheetah"))
    steps_per_second = 100;
else
    disp("NONE NONE");
end
% array_runs = [file + "*.txt"];
%     file + "0_j*.txt",...
array_runs = [
    file + "1_j*.txt",...
    file + "2_j*.txt",...
    file + "3_j*.txt",...
    file + "4_j*.txt",...
    file + "5_j*.txt",...
    file + "6_j*.txt",...
    file + "7_j*.txt",...
    file + "8_j*.txt",...
    file + "9_j*.txt",...
    file + "10_j*.txt",...
    file + "11_j*.txt",...
    file + "12_j*.txt",...
    file + "13_j*.txt",...
    file + "14_j*.txt",...
    file + "15_j*.txt",...
    file + "16_j*.txt",...
    file + "17_j*.txt",...
    file + "18_j*.txt",...
    file + "19_j*.txt",...
    file + "20_j*.txt",...
    file + "21_j*.txt",...
    file + "22_j*.txt",...
    file + "23_j*.txt",...
    file + "24_j*.txt",...
    file + "25_j*.txt",...
    file + "26_j*.txt",...
    file + "27_j*.txt",...
    file + "28_j*.txt",...
    file + "29_j*.txt",...
    file + "30_j*.txt",...
    file + "31_j*.txt",...
    file + "32_j*.txt"];

for j=1:length(array_runs)
    fd = folder + array_runs(j);
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_e] = avgseries(readseries(fd, 3, 2, steps_per_second));
    disp(mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d))));
    disp(mean(std_e(length(std_e)-steps_counted+1:length(std_e))));
end
