function rs = func_taking_mean_perf(run_mean)
    % % COUNT MEAN (LEAST 10) TO USE IN ORDERING GOO, MID AND BAD
    % % COUNT MEAN (LEAST 20) TO USE IN ORDERING SINGLE RUNS

    steps_counted = 20;
    printing =0 ;
    % root = "../../../../../../Dropbox/phd_grl_results/phd_grl_mpol_results/";
    root = "D:";
%   run_mean = "cp_single"; %["hc_single"; "pd_single"; "cp_single";"cdp_single"]

    addpath("../../../../../../Dropbox/phd_grl_results/matlab");

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

    if (printing)
        disp(run_mean)
        disp(folder+file)
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
        array_runs = [file + "*.txt"];
    end

    rs_mean = [];
    rs_std = [];
    for j=1:length(array_runs)
        fd = folder + array_runs(j);
        if (printing)
            disp(fd);
        end
        [t, mean_d, ~, std_e] = avgseries(readseries(fd, 3, 2, steps_per_second));
        rs_mean = [rs_mean; mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d)))];
        rs_std = [rs_std; mean(std_e(length(std_e)-steps_counted+1:length(std_e)))];
    end
    
    rs = [rs_mean rs_std];

    if (printing)
        disp(rs);
        disp(length(dir(fd)));
    end
end
