function executions_subploting(folder, title_fig, steps_per_second, x, y, z, array_runs)
    cLegs = containers.Map;
    cLegs("replay_ddpg_tensorflow_sincos_*txt") = "DDPG";
    env = "pendulum";
    env_abr = "pd";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_density_a1.0_*txt")) = "LEARNED DENSITY BASED";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_density_a1.0_*txt")) = "LEARNNING DENSITY BASED";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNED DATA CENTER";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNNING DATA CENTER";
    
    cLegs("cart_pole_dpg_data*txt") = "DDPG";
    env = "cart_pole";
    env_abr = "cp";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_density_a1.0_*txt")) = "LEARNED DENSITY BASED";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_density_a1.0_*txt")) = "LEARNNING DENSITY BASED";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNED DATA CENTER";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNNING DATA CENTER";
    
    cLegs("cart_double_pole_mpol_1_replay_ddpg_tensorflow_*txt") = "DDPG";
    env = "cart_double_pole";
    env_abr = "cdp";
    
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_density_a1.0_*txt")) = "LEARNED DENSITY BASED";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_density_a1.0_*txt")) = "LEARNNING DENSITY BASED";
    cLegs(strcat(env, "_mpols_load_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_load_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNED DATA CENTER";
    cLegs(strcat(env, "_mpols_yamls_results/", env, "_", env_abr, "_tau_mpol_replay_ddpg_tensorflow_sincos_16good_*_none_none_1.0_data_center_a1.0_*txt")) = "LEARNNING DATA CENTER";

    leg = [];
    hAx=gobjects(x*y,1);
    hAx(z) = subplot(x,y,z);
    
    color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
    h = zeros(1, length(array_runs));
    for j=1:size(array_runs,2)
        fd = folder + array_runs(j);
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
%     grid;
    title(title_fig);
    xlabel("seconds");
    ylabel("reward");
    legend(h, leg,"Location","southoutside");
end



