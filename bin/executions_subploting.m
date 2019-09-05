function executions_subploting(legg, folder, title_fig, steps_per_second, x, y, z, array_runs)
    cLegs = containers.Map;
    cLegs("replay_ddpg_tensorflow_sincos_*txt") = "DDPG";
    env = "pendulum";
    env_abr = "pd";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_density_a1.0_*txt")) = "LEARNED DENSITY BASED";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_density_a1.0_*txt")) = "LEARNNING DENSITY BASED";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNED DATA CENTER";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNNING DATA CENTER";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.5_density_a0.01_*txt")) = "LEARNED ME\_50\_D\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.5_density_a0.01_*txt")) = "LEARNNING  ME\_50\_D\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_data_center_linear_order_1.0_best_a0.01_*txt")) = "LEARNED DCO\_100\_B\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_data_center_linear_order_1.0_best_a0.01_*txt")) = "LEARNNING DCO\_100\_B\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt")) = "LEARNED ME\_50\_DC\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt")) = "LEARNNING ME\_50\_DC\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.1_best_a0.01_*txt")) = "LEARNED ME\_10\_B\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.1_best_a0.01_*txt")) = "LEARNNING ME\_10\_B\_HB";
    
%     cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_")) = "LEARNED ";
%     cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_")) = "LEARNNING ";
    
    cLegs("cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*txt") = "DDPG";
    env = "cart_pole";
    env_abr = "cp";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_density_a1.0_*txt")) = "LEARNED DENSITY BASED";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_density_a1.0_*txt")) = "LEARNNING DENSITY BASED";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNED DATA CENTER";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNNING DATA CENTER";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.5_density_a0.01_*txt")) = "LEARNED ME\_50\_D\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.5_density_a0.01_*txt")) = "LEARNNING  ME\_50\_D\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_data_center_linear_order_1.0_best_a0.01_*txt")) = "LEARNED DCO\_100\_B\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_data_center_linear_order_1.0_best_a0.01_*txt")) = "LEARNNING DCO\_100\_B\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt")) = "LEARNED ME\_50\_DC\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt")) = "LEARNNING ME\_50\_DC\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.1_best_a0.01_*txt")) = "LEARNED ME\_10\_B\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.1_best_a0.01_*txt")) = "LEARNNING ME\_10\_B\_HB";
    
    cLegs("cart_double_pole_mpol_1_replay_ddpg_tensorflow_*txt") = "DDPG";
    env = "cart_double_pole";
    env_abr = "cdp";
    
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_density_a1.0_*txt")) = "LEARNED DENSITY BASED";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_density_a1.0_*txt")) = "LEARNNING DENSITY BASED";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNED DATA CENTER";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNNING DATA CENTER";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.5_density_a0.01_*txt")) = "LEARNED ME\_50\_D\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.5_density_a0.01_*txt")) = "LEARNNING  ME\_50\_D\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_data_center_linear_order_1.0_best_a0.01_*txt")) = "LEARNED DCO\_100\_B\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_data_center_linear_order_1.0_best_a0.01_*txt")) = "LEARNNING DCO\_100\_B\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt")) = "LEARNED ME\_50\_DC\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt")) = "LEARNNING ME\_50\_DC\_HB";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_mean_euclidian_distance_0.1_best_a0.01_*txt")) = "LEARNED ME\_10\_B\_HB";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_mean_euclidian_distance_0.1_best_a0.01_*txt")) = "LEARNNING ME\_10\_B\_HB";

    
    leg = [];
    hAx=gobjects(x*y,1);
    hAx(z) = subplot(x,y,z);
    
    color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
    h = zeros(1, length(array_runs));
    for j=1:size(array_runs,2)
        fd = folder + array_runs(j);
        disp(fd);
        data = readseries(fd, 3, 2, steps_per_second);
        [t, mean_d, ~, std_d] = avgseries(data);
        n_color = color(1 + rem(j, length(color)));
        h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
        if cLegs.isKey(array_runs(j))
            leg = [leg, cLegs(array_runs(j))];
        end
        hold on;
    end
    if (env == "pendulum")
        xlim(hAx(z), [0 3000]);
        ylim(hAx(z), [-2500 -600]);
    elseif (env == "cart_pole")
        xlim(hAx(z), [0 5000]);
        ylim(hAx(z), [-2000 600]);
    elseif (env == "cart_double_pole")
        xlim(hAx(z), [0 5000]);
        ylim(hAx(z), [-2500 700]);
    else
        disp("--------------");
    end
    grid;
    title(title_fig);
    xlabel("seconds");
    ylabel("reward");
    if(legg == 1 )
        legend(h, leg,"Location","southoutside");
    end
end
