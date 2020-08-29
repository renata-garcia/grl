clc;
clear;
close all;

% % COUNT MEAN (LEAST 10) TO USE IN ORDERING GOO, MID AND BAD
% % COUNT MEAN (LEAST 20) TO USE IN ORDERING SINGLE RUNS

run_mean = "pd_gd_e_avg"; %["pd_gd_e_avg"; "pd_gd_e_lrc31_i0"; "pd_gd_e_lrc31_i1"; "pd_gd_e_lrc21_i1"]
run_mean = "hc_single"; %["hc_single"; "pd_single"; "cp_single";"cdp_single"]
run_mean = "hc_mpols_tg_good_tg_ddpg16_mean_"; %["hc_single"; "pd_single"; "cp_single";"cdp_single"]
run_mean = "cp_fd_rnd_alternately_persistent_fd_tg_good_tg_ddpg16_strat_mean_";
%env_abr
%_fd_rnd_relu_fd_ _fd_rnd_cov_relu_fd_ _fd_rnd_relu_4gamma_fd_
%_fd_rnd_relu_4gamma_cov_fd_ _fd_rnd_n_1_fd_
%_mpols_ddpg16_ _mpols_ddpg3_
%_dced25dc _dc _rnd_n_1

%#HOST
%_fd_rnd_alternately_persistent_fd_
%_fd_mpols_fd_

environment = "hc"; %hx
type = ["good", "bad"]; %"good", "mid", "bad"
strategy = ["mean", "data_center", "density"]; %"mean", "data_center", "density", "random"
mode = "ddpg16"; % ddpg16 ddpg8 ddpg3 ddpg3mirror ddpg8mirror ddpg12mirror ddpg3duel
load = "";%"_load"; %
host = "_fd_mpols_fd_";

if (mode == "ddpg3duel") && (environment == "hc")
    environment = "hx";
end

for i=1:length(type)
    for j=1:length(strategy)
        teste(environment + host + "tg_" + type(i) + "_tg_" + mode + "_strat_" + strategy(j) + "_", load, 0);
    end
end

function teste(run_mean, load, modedisplay)
    printing = 0;
    withLimiar = 0;
    steps_counted = 10;
    steps_per_second = 0;
    root = config_env_os(0);
    mddisp = modedisplay;
    env = "";
    file="";
    folder="";

    if (contains(run_mean,"pd"))
        env = "pendulum"; env_abr = "_pd";
    elseif(contains(run_mean,"cp"))
        env = "cart_pole"; env_abr = "_cp";
    elseif(contains(run_mean,"cdp"))
        env = "cart_double_pole"; env_abr = "_cdp";
    elseif(contains(run_mean,"hc") || contains(run_mean,"hx"))
        env = "half_cheetah"; env_abr = "";
    end
    
    if (printing)
        disp("env::env_abr>> " + env +" :: " + env_abr);
    end

    if (contains(run_mean,"_tg_good_tg_"))
        tg = "good" + load;
    elseif (contains(run_mean,"_tg_mid_tg_"))
        tg = "mid" + load;
    elseif (contains(run_mean,"_tg_bad_tg_"))
        tg = "bad" + load;
    end

    if (contains(run_mean,"_ddpg16_"))
        ddpg_sz = "16";
    elseif (contains(run_mean,"_ddpg8_"))
        ddpg_sz = "8";
    elseif (contains(run_mean,"_ddpg3_"))
        ddpg_sz = "3";
    elseif (contains(run_mean,"_ddpg3mirror_"))
        ddpg_sz = "3mirror";
    elseif (contains(run_mean,"_ddpg8mirror_"))
        ddpg_sz = "8mirror";
    elseif (contains(run_mean,"_ddpg12mirror_"))
        ddpg_sz = "12mirror";
    elseif (contains(run_mean,"_ddpg3duel_"))
        ddpg_sz = "3duel";
    end

    if (contains(run_mean,"single"))
        folder = root + "tests_framework/" + env+"_yamls_results/";
        file = env + env_abr + "_" + "tau_replay_ddpg_tensorflow_sincos_i";
        alg = "";
        steps_counted = 20;
    end

    if (contains(run_mean,"mpols"))
        folder = root + "tests_framework/" + env+"_mpols_yamls_results/";
        file = env + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_" + ddpg_sz + tg + "*";
        alg = "";
        steps_counted = 20;
    %     if(contains(run_mean, "_ddpg16_density_"))
    %         file = file + tg + "*" + "none_none_1.0_density_a1.0";
    %     end
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

    if (contains(run_mean,"_fd_rnd_relu_fd_"))
        folder = root + "tests_random_hyperparameters/" + env_abr + "_agent_mpol_and_single_config_ddpg_rnd1a10_token_no_softmax_results/";
        file = env + "_" + env_abr + "_rnd_";
        alg = "";
    elseif (contains(run_mean,"_fd_rnd_cov_relu_fd_"))
        folder = root + "tests_random_hyperparameters/" + env_abr + "_agent_mpol_and_single_config_ddpg_rnd1a10_token_no_softmax_results_converged/";
        file = env + "_" + env_abr + "_rnd_";
        alg = "";
    elseif (contains(run_mean,"_fd_rnd_relu_4gamma_fd_"))
        folder = root + "tests_random_hyperparameters/" + env_abr + "_agent_mpol_and_single_config_ddpg_rnd1a10_token_no_softmax_4gamma_results/";
        file = env + "_" + env_abr + "_rnd_";
        alg = "";
    elseif (contains(run_mean,"_fd_rnd_relu_4gamma_cov_fd_"))
        folder = root + "tests_random_hyperparameters/" + env_abr + "_agent_mpol_and_single_config_ddpg_rnd1a10_token_no_softmax_4gamma_results_converged/";
        file = env + "_" + env_abr + "_rnd_";
        alg = "";
    end

    if (contains(run_mean,"_fd_rnd_n_1_fd_"))
        file = env + "_" + env_abr + "_rnd_";
    elseif (contains(run_mean,"hc_fd_rnd_alternately_persistent_fd_"))
        folder = root + "tests_ddpg_2020/" + env + "/";
        if (ddpg_sz == "16")
            file = env + "_tau_replay_ddpg_tensorflow_sincos" + ddpg_sz + tg + "_j*_alternately_persistent_"; 
        else
            file = env + "_tau_replay_ddpg_tensorflow_sincos" + ddpg_sz + tg + "_";
        end
    elseif (contains(run_mean,"_fd_rnd_alternately_persistent_fd_"))
        folder = root + "tests_ddpg_2020/" + env + "/";
        file = env + env_abr + "_tau_replay_ddpg_tensorflow_sincos" + ddpg_sz + tg + "_j*_";
    end

    if (contains(run_mean,"_ddpg16_dced25dc"))
        file = file + "*_tau_replay_ddpg_tensorflow_sincos16_j0_data_center_euclidian_distance_0.25_data_center_a0.01_";
    elseif (contains(run_mean,"_ddpg16_dc"))
        file = file + "*_tau_replay_ddpg_tensorflow_sincos16_j0_none_none_1.0_data_center_a1.0_";
    elseif (contains(run_mean,"_ddpg3_dced25dc"))
        file = file + "*_tau_replay_ddpg_tensorflow_sincos3_j0_data_center_euclidian_distance_0.25_data_center_a0.01_";
    elseif (contains(run_mean,"_ddpg3_dc"))
        file = file + "*_tau_replay_ddpg_tensorflow_sincos3_j0_none_none_1.0_data_center_a1.0_";
    elseif (contains(run_mean,"_n_1"))
        file = file + "1_tau_replay_ddpg_tensorflow_sincos_i*_j0";
    elseif (contains(run_mean,"_strat_mean_"))
        file = file + "none_none_1.0_mean_a1.0_";
    elseif (contains(run_mean,"_strat_data_center_"))
        file = file + "none_none_1.0_data_center_a1.0_";
    elseif (contains(run_mean,"_strat_density_"))
        file = file + "none_none_1.0_density_a1.0_";
    elseif (contains(run_mean,"_strat_random_"))
        file = file + "none_none_1.0_random_a1.0_";
    end
    %"pd_rnd_relu_mpol_dced25dc"; "pd_rnd_relu_mpol_dc"; "pd_rnd_relu_1"; 

    if (printing)
        disp(run_mean);
        disp(folder+file);
    end

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

    if (contains(run_mean,"single"))
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

    %% withLimiar

    %checks if number file has minimum runs_number
    for j=1:length(array_runs)

        fd = folder + array_runs(j);
        data_no_limiar = readseries(fd, 3, 2, steps_per_second);

        data = {};
        if (withLimiar)
            k = 0;
            for i=1:length(data_no_limiar)
                tmp = data_no_limiar{i};
                disp(mean(tmp(length(tmp)-steps_counted+1:length(tmp),2)));
                if (mean(tmp((end-5):end,2)) > withLimiar)
                    k = k + 1;
                    data{k} = data_no_limiar{i};
                end
            end
        end

        if (length(data) > 0)
            [t, mean_d, ~, std_e] = avgseries(data);
            d = data(end,:);
        else
            [t, mean_d, ~, std_e] = avgseries(data_no_limiar);
            d = data_no_limiar(end,:);
        end

    %     fd = folder + array_runs(j);
        if (printing)
            disp(fd);
        end
    %     [t, mean_d, ~, std_e] = avgseries(readseries(fd, 3, 2, steps_per_second));
        mean_i = mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d)));
        std_e_i = mean(std_e(length(std_e)-steps_counted+1:length(std_e)));
        if (mddisp == 0)
            fprintf("%.0f  %.0f ", mean_i, 1.96 * std_e_i);
        elseif (mddisp == 1)
            fprintf("%.0f ", mean_i);
        elseif (mddisp == 2)
            fprintf("%.0f ", 1.96 * std_e_i);
        end
%         if (mddisp == 0)
%             fprintf("%.0f \n %.0f \n", mean_i, 1.96 * std_e_i);
%         elseif (mddisp == 1)
%             fprintf("%.0f \n", mean_i);
%         elseif (mddisp == 2)
%             fprintf("%.0f \n", 1.96 * std_e_i);
%         end
    end

%     if (mddisp == 0)
%         if (length(data) > 0)
%            fprintf("%d \n", length(data));
%         else
%            fprintf("%d \n", length(dir(fd)));
%         end
%     end

    if (mddisp == 0)
        if (length(data) > 0)
           fprintf("%d ", length(data));
        else
           fprintf("%d ", length(dir(fd)));
        end
    end
    
end
