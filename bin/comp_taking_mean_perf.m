clc;
clear;
close all;

% % COUNT MEAN (LEAST 10) TO USE IN ORDERING GOO, MID AND BAD
% % COUNT MEAN (LEAST 20) TO USE IN ORDERING SINGLE RUNS

steps_counted = 20;
steps_per_second = 0;
printing =1 ;
root = config_env_os();
env = "";
run_mean = "pd_gd_e_avg"; %["pd_gd_e_avg"; "pd_gd_e_lrc31_i0"; "pd_gd_e_lrc31_i1"; "pd_gd_e_lrc21_i1"]
run_mean = "cp_single"; %["hc_single"; "pd_single"; "cp_single";"cdp_single"]
run_mean = "pd_rnd_cov_relu_mpol_ddpg16_dc"; %["pd_rnd_n_mpol_ddpg16_dced25dc"; "pd_rnd_n_mpol_ddpg16_dc"; "pd_rnd_n_1";
%"pd_rnd_relu_mpol_ddpg16_dced25dc"; "pd_rnd_relu_mpol_ddpg16_dc"; "pd_rnd_relu_mpol_ddpg3_dced25dc"; "pd_rnd_relu_mpol_ddpg3_dc";]
%"pd_rnd_cov_relu_mpol_ddpg16_dced25dc"; "pd_rnd_cov_relu_mpol_ddpg16_dc"; "pd_rnd_cov_relu_mpol_ddpg3_dced25dc"; "pd_rnd_cov_relu_mpol_ddpg3_dc";]


%folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_mpols" +alg + "_load_yamls_results/";
%folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_mpols" +alg + "_yamls_results/";
% alg_t = "_none_none_1.0_data_center_a1.0_";
% alg_t = "_none_none_1.0_density_a1.0_";
% alg_t = "_none_none_1.0_mean_a1.0_";
% alg_t = "_none_data_center_linear_order_1.0_best_a0.01_";
% alg_t = "_none_density_1.0_best_a0.01_";
% alg_t = "_mean_euclidian_distance_0.1_best_a0.01_";
% alg_t = "_data_center_euclidian_distance_0.25_data_center_a0.01_";
% alg_t = "_none_density_0.25_density_a0.01_";
% alg_t = "_mean_euclidian_distance_0.25_mean_a0.01_";
% alg_t = "_mean_euclidian_distance_0.25_data_center_a0.01_";
% alg_t = "_mean_euclidian_distance_0.25_density_a0.01_";
% alg_t = "_none_data_center_linear_order_0.25_data_center_a0.01_";
% type = "good";
% env = "cart_double_pole";
% folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_mpols_loadnewgrptest_yamls_results/";
% file = env + "_tau_replay_ddpg_tensorflow_sincos16"+type+"_load_j*" + alg_t;

if (contains(run_mean,"pd") && contains(run_mean,"single"))
    env = "pendulum"; env_abr = "pd_";
elseif(contains(run_mean,"cp") && contains(run_mean,"single"))
    env = "cart_pole"; env_abr = "cp_";
elseif(contains(run_mean,"cdp") && contains(run_mean,"single"))
    env = "cart_double_pole"; env_abr = "cdp_";
elseif(contains(run_mean,"hc") && contains(run_mean,"single"))
    env = "half_cheetah"; env_abr = "wc_";
end

if (contains(run_mean,"single"))
    folder = root + env+"_yamls_results/";
    file = env + "_" + env_abr + "tau_replay_ddpg_tensorflow_sincos_i";
    alg = "";
    steps_counted = 20;
end

if(contains(run_mean,"hc") && contains(run_mean,"single"))
    file = env + "_" + "tau_replay_ddpg_tensorflow_sincos_i";
end

% %News Tests, if persists todo refactore
if (contains(run_mean,"pd") && contains(run_mean,"_e_avg") && contains(run_mean,"_gd_"))
    env = "pendulum";
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_ensemble_yamls_results/";
    file = env + "_16good_avg-";
    steps_counted = 20;
elseif (contains(run_mean,"pd") && contains(run_mean,"_e_lrc31_i0") && contains(run_mean,"_gd_"))
    env = "pendulum";
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_ensemble_yamls_results/";
    file = env + "_16good_ens_lrcritic0001_init0-";
    steps_counted = 20;
elseif (contains(run_mean,"pd") && contains(run_mean,"_e_lrc31_i1") && contains(run_mean,"_gd_"))
    env = "pendulum";
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_ensemble_yamls_results/";
    file = env + "_16good_init1-";
    steps_counted = 20;
elseif (contains(run_mean,"pd") && contains(run_mean,"_e_lrc21_i1") && contains(run_mean,"_gd_"))
    env = "pendulum";
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/"+env+"_ensemble_yamls_results/";
    file = env + "_16good_ens_lrcritic001_init1-";
    steps_counted = 20;
end

if (contains(run_mean,"pd") && contains(run_mean,"_rnd_"))
    env = "pendulum";
    env_abr = "pd";
elseif (contains(run_mean,"cp") && contains(run_mean,"_rnd_"))
    env = "cart_pole";
    env_abr = "cp";
elseif (contains(run_mean,"cdp") && contains(run_mean,"_rnd_"))
    env = "cart_double_pole";
    env_abr = "cdp";
elseif (contains(run_mean,"hc") && contains(run_mean,"_rnd_"))
    env = "half_cheetah";
    env_abr = "hc";
end
if (contains(run_mean,"_rnd_n"))
    folder = root + "tests_random_hyperparameters/" + env_abr + "_agent_mpol_and_single_config_ddpg_rnd1a10_results/";
    file = env + "_" + env_abr + "_rnd_";
elseif (contains(run_mean,"pd") && contains(run_mean,"_rnd_relu"))
    folder = root + "tests_random_hyperparameters/" + env_abr + "_agent_mpol_and_single_config_ddpg_rnd1a10_token_no_softmax_results/";
    file = env + "_" + env_abr + "_rnd_";
    alg = "";
elseif (contains(run_mean,"pd") && contains(run_mean,"_rnd_cov_relu"))
    folder = root + "tests_random_hyperparameters\" + env_abr + "_agent_mpol_and_single_config_ddpg_rnd1a10_token_no_softmax_results_converged\";
    file = env + "_" + env_abr + "_rnd_";
    alg = "";
end
if (contains(run_mean,"pd") && contains(run_mean,"_ddpg16_dced25dc"))
    file = file + "*_tau_replay_ddpg_tensorflow_sincos16_j0_data_center_euclidian_distance_0.25_data_center_a0.01_";
elseif (contains(run_mean,"pd") && contains(run_mean,"_ddpg16_dc"))
    file = file + "*_tau_replay_ddpg_tensorflow_sincos16_j0_none_none_1.0_data_center_a1.0_";
elseif (contains(run_mean,"pd") && contains(run_mean,"_ddpg3_dced25dc"))
    file = file + "*_tau_replay_ddpg_tensorflow_sincos3_j0_data_center_euclidian_distance_0.25_data_center_a0.01_";
elseif (contains(run_mean,"pd") && contains(run_mean,"_ddpg3_dc"))
    file = file + "*_tau_replay_ddpg_tensorflow_sincos3_j0_none_none_1.0_data_center_a1.0_";
elseif (contains(run_mean,"pd") && contains(run_mean,"_n_1"))
    file = file + "1_tau_replay_ddpg_tensorflow_sincos_i*_j0";
end
%"pd_rnd_relu_mpol_dced25dc"; "pd_rnd_relu_mpol_dc"; "pd_rnd_relu_1"; 

disp(run_mean);
disp(folder+file);

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

if (contains(run_mean,"single")) || (contains(run_mean,"mpols"))
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
else
    array_runs = [
        file + "*.txt"];
end

for j=1:length(array_runs)
    fd = folder + array_runs(j);
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_e] = avgseries(readseries(fd, 3, 2, steps_per_second));
    disp(mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d))));
    if (printing)
        disp(mean(std_e(length(std_e)-steps_counted+1:length(std_e))));
    end
end
disp(length(dir(fd)));
