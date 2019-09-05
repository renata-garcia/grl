clc;
clear;
close all;

% %
init_size_env = 1;
size_env = 1;
envs_results = cell(1,size_env);
for it=init_size_env:size_env
    printing = 1;
    steps_counted = 10;
    ie=it;
    ia=1;
    withLoad = 0;
    withNoise = 0;
    withlimiar = 1;
    onlybad4pend=0;
    algs = ["ac_tc", "dpg", "ddpg"];
    if (ie == 1)
        env = "pendulum"; env_abr = "pd";
    elseif (ie == 2)
        env = "cart_pole"; env_abr = "cp";
    elseif (ie == 3)
        env = "cart_double_pole"; env_abr = "cdp";
    elseif (ie == 4)
        env = "walker"; env_abr = "cw";
    end
    alg = algs(ia);
    [tbl_meanstd_all, percentual, strategies] = generate_tbl(printing, env, env_abr, alg, withLoad, withNoise, onlybad4pend, withlimiar);
    
    envs_results{1,ie} = tbl_meanstd_all;
    
    title_leg = strcat("env= ", env, " alg= ", algs(ia));
    if (withlimiar)
        title_leg = strcat(title_leg, " limi-2500");
    else
        title_leg = strcat(title_leg, " (counted)");
    end
    if (withNoise)
        title_leg = strcat(title_leg, " NOISE AND NOT LOAAAADDD");
    end
%     print_learning_learned_by_groups(title_leg, strategies, tbl_meanstd_all, withLoad, percentual)
    disp("acabou..........");
end
print_by_envs(title_leg, strategies, envs_results, 1, withLoad, percentual)

function [tbl_meanstd_all, percentual, strategies] = generate_tbl(printing, env, env_abr, alg, withLoad, withNoise, exc, withlimiar)
    steps_counted = 10;
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
    addpath("~/Dropbox/phd_grl_results/matlab");

    group = ["good", "mid", "bad"];
    if (exc)
        group = ["bad"];
    end

    load = [""];
    if(withLoad && withNoise)
        load = ["", "_noisemulti"];
    elseif (withLoad)
        load = ["", "_load"];
    elseif (withNoise)
        disp("ERR: not load and noise");
        return;
    end

    n_group = length(group);
    n_load = length(load);
    ng = 2*n_group;
    nl = 2*n_load;

    % %
    n_env = 1;
    n_vert = 12; %22; %
    tbl_meanstd_all = zeros(n_vert, n_env*ng*n_load);
    percentual = zeros(n_vert, n_env*n_group*n_load);

    if (contains(env,"cart"))
        steps_per_second = 19;
    elseif (contains(env,"pendulum"))
        steps_per_second = 33;
    elseif (contains(env,"walker"))
        steps_per_second = 5;
    else
        disp("NONE NONE");
    end

    strategies = ["DC",...
                  "D",...
                  "M",...
                  "RND",...
                  "DC\_MA\_B",...
                  "D\_MA\_50\_D",...
                  "D\_MA\_50\_DC",...
                  "D\_MA\_B",...
                  "D\_ED\_MA\_B",...
                  "M\_ED\_MA\_B",...
                  "M\_ED\_MA\_50\_D",...
                  "M\_ED\_MA\_50\_DC"];
              
    strategies = ["DC",...
                  "D",...
                  "M",...
                  "RND",...
                  "DC\_MA\_B",...
                  "DC\_MA\_25\_DC",...
                  "DC\_MA\_50\_DC",...
                  "DC\_MA\_75\_DC",...
                  "DC\_MA\_50\_D",...
                  "D\_MA\_50\_D",...
                  "D\_MA\_50\_DC",...
                  "D\_MA\_B",...
                  "DC\_ED\_MA\_25\_DC",...
                  "DC\_EC\_MA\_50\_DC",...
                  "DC\_ED\_MA\_75\_DC",...
                  "DC\_ED\_MA\_B",...
                  "D\_ED\_MA\_B",...
                  "M\_ED\_MA\_B",...
                  "M\_ED\_MA\_25\_D",...
                  "M\_ED\_MA\_50\_D",...
                  "M\_ED\_MA\_75\_D",...
                  "M\_ED\_MA\_50\_DC",...
                  "DLO\_MA\_50\_D",...
                  "DLO\_MA\_50\_DC",...
                  "DLO\_MA\_50\_B"];
              
    for ig = 1:n_group
        for il = 1:n_load                       
                                            
             runs_generic = [group(ig) + load(il) + "_*_none_none_1.0_data_center_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_density_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_mean_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_random_a1_-*txt",...
                            group(ig) + load(il) + "_*_none_data_center_linear_order_1.0_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_0.5_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_0.5_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_1.0_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_density_euclidian_distance_0.01_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.1_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.5_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.5_data_center_a0.01_-*txt"];
             runs_generic = [group(ig) + load(il) + "_*_none_none_1.0_data_center_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_density_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_mean_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_random_a1_-*txt",...
                            group(ig) + load(il) + "_*_none_data_center_linear_order_1.0_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_data_center_linear_order_0.25_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_data_center_linear_order_0.5_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_data_center_linear_order_0.75_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_data_center_linear_order_0.5_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_0.5_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_0.5_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_1.0_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_data_center_euclidian_distance_0.25_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_data_center_euclidian_distance_0.5_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_data_center_euclidian_distance_0.75_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_data_center_euclidian_distance_0.1_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_density_euclidian_distance_0.01_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.1_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.25_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.5_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.75_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.5_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_linear_order_0.5_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_linear_order_0.5_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_linear_order_1.0_best_a0.01_-*txt"];
            i_load = (ng*n_load) + ng*(il-1) + (2*ig)-1; %(ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)-1
            j_load = (ng*n_load) + ng*(il-1) + (2*ig); %(ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)
            i = nl*(ig-1) + 2*il -1; %(ng*n_load)*(ie-1) + 
            j = nl*(ig-1) + 2*il;%(ng*n_load)*(ie-1) + 
            k = n_load*(ig-1) + il; %(ng*n_load)*(ie-1) + 
            [tbl2, perc2] = test_take_mean_mpol(folder, env, env_abr, load(il), alg, runs_generic, printing, steps_per_second, steps_counted, withlimiar);
            [tbl_meanstd_all(:, i:j), percentual(:,k)] = test_take_mean_mpol(folder, env, env_abr, load(il), alg, runs_generic, printing, steps_per_second, steps_counted, withlimiar);
        end
	end

	if (exc)
            type = "good";
            runs_specific_good = ["r25" + type + "_*_mean_euclidian_distance_0.25_density_a0.01_*.txt",...
                                  "r05" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
                                  "r25" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
                                  "r50" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
                                          type + "_*_none_density_linear_order_0.1_best_a0.01_*.txt",...
                                          type + "_*_none_density_linear_order_0.5_data_center_a0.01_*.txt",...
                                          type + "_*_none_density_linear_order_0.5_density_a0.01_*.txt"];
            [tbl_meanstd_specific_good, percentual_spec_good] = test_take_mean_mpol(folder, env, env_abr, "", alg, runs_specific_good, printing, steps_per_second, steps_counted, withlimiar);

            type = "mid";
            runs_specific_mid = [         type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
                                  "r05" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
                                  "r25" + type + "_*_mean_euclidian_distance_0.25_density_a0.01_*.txt",...
                                  "r25" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt"];
            [tbl_meanstd_specific_mid, percentual_spec_mid] = test_take_mean_mpol(folder, env, env_abr, "", alg, runs_specific_mid, printing, steps_per_second, steps_counted, withlimiar);

            type = "bad";
            runs_specific_bad = [         type + "_*_none_data_center_linear_order_0.25_data_center_a0.01_-*txt",...
                                          type + "_*_none_data_center_linear_order_0.5_data_center_a0.01_-*txt",...
                                          type + "_*_none_data_center_linear_order_0.75_data_center_a0.01_-*txt",...
                                          type + "_*_none_data_center_linear_order_0.5_density_a0.01_-*txt",...
                                          type + "_*_data_center_euclidian_distance_0.1_best_a0.01_-*txt",...
                                          type + "_*_data_center_euclidian_distance_0.1_best_a0.02_-*txt",...
                                          type + "_*_data_center_euclidian_distance_0.25_data_center_a0.01_*.txt",...
                                          type + "_*_data_center_euclidian_distance_0.5_data_center_a0.005_*.txt",...
                                          type + "_*_data_center_euclidian_distance_0.5_data_center_a0.01_*.txt",...
                                          type + "_*_data_center_euclidian_distance_0.5_data_center_a0.02_*.txt",...
                                          type + "_*_data_center_euclidian_distance_0.75_data_center_a0.01_*.txt",...
                                          type + "_*_mean_euclidian_distance_0.25_density_a0.01_*.txt",...
                                          type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
                                  "r05" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
                                  "r25" + type + "_*_mean_euclidian_distance_0.25_density_a0.01_*.txt",...
                                  "r25" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
                          "r50" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt"];
        [tbl_meanstd_specific_bad, percentual_spec_bad] = test_take_mean_mpol(folder, env, env_abr, "", alg, runs_specific_bad, printing, steps_per_second, steps_counted, withlimiar);
        
        disp(tbl_meanstd_specific_good);
        disp(tbl_meanstd_specific_mid);
        disp(tbl_meanstd_specific_bad);
    end
% print_tbl_good_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good);
% print_tbl_good_std_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, stdpd_good, bpd, bstdpd);
% print_tbl_all_std_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, stdpd_good, pd_mid, stdpd_mid, pd_bad, stdpd_bad);

%disp(tbl_meanstd_all);
end

function [means_std, percentual] = test_take_mean_mpol(folder, env, env_abr, load, alg, runs, printing, steps_per_second, steps_counted, withLimiar)
    subfolder = "";
    preffix = "";
    
    if (alg == "ac_tc" || alg == "dpg")
        subfolder = env + "_mpols" + "_" + alg + load + "_yamls_results/";
        preffix = env + "_" + env_abr +"_tau_" + alg + "16";
    elseif (alg == "ddpg")
        subfolder = env + "_mpols" + load + "_yamls_results/";
        preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16";
    end

    array_runs = runs;
    for i = 1:length(runs)
        array_runs(i) = subfolder + preffix + runs(i);
    end

    fd = folder + array_runs(1);
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_e] = avgseries(readseries(fd, 3, 2, steps_per_second));

    means_std = zeros(length(array_runs), 2);
    percentual = zeros(length(array_runs), 1);
    for j=1:length(array_runs)
        fd = folder + array_runs(j);
        if (printing)
            disp(fd);
        end
        
        data_no_limiar = readseries(fd, 3, 2, steps_per_second);
        if (length(data_no_limiar) ~= 10)
            disp(fd);
        end

        data = {};
        if (withLimiar)
            k = 0;
            for i=1:length(data_no_limiar)
                tmp = data_no_limiar{i};
                if (mean(tmp((end-5):end,2)) > -2500)
                    k = k + 1;
                    data{k} = data_no_limiar{i};
                    percentual(j) = percentual(j) + 1;
                end
            end
        else
            for i=1:length(data_no_limiar)
                percentual(j) = percentual(j) + 1;
            end
        end
        if (length(data) > 0)
            [t, mean_d, ~, std_e] = avgseries(data);
        else
            [t, mean_d, ~, std_e] = avgseries(data_no_limiar);
        end
        means_std(j, 1) = mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d)));
        means_std(j, 2) = mean(std_e(length(std_e)-steps_counted+1:length(std_e)));
    end
end

function print_learning_learned_by_groups(caption, strategies, tbl, withLoad, percentual)
    sz_base = 4;
    ind_max = 1;
    jmp_grp = 2;
    bests =  zeros(1, 6);
    j = 1;
    for i=ind_max:jmp_grp:size(tbl,2)
    	max_base = max(tbl(1:sz_base, i));
        ind_max_base = tbl(1:sz_base, i) == max_base;
        iline = (1:sz_base)*ind_max_base;
        max_basestd = max_base - tbl(iline,i+1);
        bests(j) = max_basestd;
        j=j+1;
    end
    disp(bests);
              
	fprintf("%% Please add the following required packages to your document preamble:\n");
    fprintf("%% \\usepackage{multirow}\n");
    fprintf("  \\begin{table*}[]\n");
    fprintf("  \\centering\n");
    fprintf("  \\footnotesize\n");
    fprintf("  \\caption{%s}\n", caption);
    fprintf("  \\label{tab_performance_all}\n");
    fprintf("  \\begin{tabular}{l|c|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{4.4}|}\n");
    fprintf("    \\cline{2-8}\n");
    fprintf("     & \\multirow{2}{*}{strategy} & \\multicolumn{2}{c|}{good} & \\multicolumn{2}{c|}{mid} & \\multicolumn{2}{c|}{bad} \\\\ \\cline{3-8} \n");
    fprintf("     &  & \\multicolumn{1}{|c|}{learning} & \\multicolumn{1}{|c|}{learned} & \\multicolumn{1}{|c|}{learning} & \\multicolumn{1}{|c|}{learned} & \\multicolumn{1}{|c|}{learning} & \\multicolumn{1}{|c|}{learned} \\\\ \\hline\n");
    for j=1:sz_base
        if (j == 1)
            fprintf("    \\multicolumn{1}{|l|}{\\multirow{%d}{*}", sz_base);
            fprintf("{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{%s}", strategies(j));
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}", strategies(j));
        end
        k = 1;
        ii = 0;
        for i=1:2:size(tbl,2)
            ii = ii + 1;
            k = ii;
            fprintf(" & ");
            if ((tbl(j, i)+tbl(j, i+1)) >= bests(k))
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)", tbl(j, i:i+1), percentual(j,ii));
            else
                fprintf("%.0f,%.0f (%d)", tbl(j, i:i+1), percentual(j,ii));
            end
        end
        if(j==sz_base)
            fprintf(" \\\\ \\hline \n");
        else
           fprintf(" \\\\ \\cline{2-8} \n");
        end
        
    end
    for j=(sz_base + 1):size(tbl, 1)
        if (j == (sz_base + 1))
            fprintf("    \\multicolumn{1}{|l|}{\\multirow{%d}{*}", (size(tbl, 1)-sz_base));
            fprintf("{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & \\footnotesize{%s}", strategies(j));
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}", strategies(j));
        end
        ii = 0;
        for i=1:2:size(tbl,2)
            ii = ii + 1;
            k = ii;
            fprintf(" & ");
            if ((tbl(j, i)+tbl(j, i+1)) >= bests(k))
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)", tbl(j, i:i+1), percentual(j,ii));
            else
                fprintf("%.0f,%.0f (%d)", tbl(j, i:i+1), percentual(j,ii));
            end
        end
        if (j == size(tbl, 1))
            fprintf(" \\\\ \\hline \n");
        else
            fprintf(" \\\\ \\cline{2-8} \n");
        end
    end
    fprintf("  \\end{tabular}\n");
    fprintf("\\end{table*}\n");
end

function print_by_envs(caption, strategies, cell, group, withLoad, percentual)
    sz_envs = length(cell);
    sz_tbl = length(cell{1,1});
    igroup = group*2 -1;
    sz_base = 4;
    bests =  zeros(1, sz_envs);
    for i=1:sz_envs
    	max_base = max(cell{1,i}(1:sz_base, group));
        ind_max_base = cell{1,i}(1:sz_base, group) == max_base;
        iline = (1:sz_base)*ind_max_base;
        max_basestd = max_base - cell{1,i}(iline,i+1);
        bests(i) = max_basestd;
        i=i+1;
    end
    disp(bests);
              
	fprintf("%% Please add the following required packages to your document preamble:\n");
    fprintf("%% \\usepackage{multirow}\n");
    fprintf("  \\begin{table*}[]\n");
    fprintf("  \\centering\n");
    fprintf("  \\footnotesize\n");
    fprintf("  \\caption{%s}\n", caption);
    fprintf("  \\label{tab_performance_all}\n");
    fprintf("  \\begin{tabular}{l|c|");
    for icolumn=1:sz_envs
        fprintf("D{,}{\\pm}{-1}|");
    end
    fprintf("}\n");
    fprintf("    \\cline{2-%d}\n", sz_envs+2);
    fprintf("     & \\multirow{1}{*}{strategy} & ");
    for icolumn=1:sz_envs
        fprintf("\\multicolumn{1}{c|}{env} & ");
    end
    fprintf("\\cline{3-%d} \\hline \n", sz_envs+2);
    for ibase=1:sz_base
        if (ibase == 1)
            fprintf("    \\multicolumn{1}{|l|}{\\multirow{%d}{*}", sz_base);
            fprintf("{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{%s}", strategies(ibase));
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}", strategies(ibase));
        end
        icolumn = 0;
        for i=1:sz_envs
            icolumn = icolumn + 1;
            fprintf(" & ");
            if ((cell{1,i}(ibase, group)+cell{1,i}(ibase, group+1)) >= bests(icolumn))
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)", cell{1,i}(ibase, igroup:igroup+1), percentual(ibase,icolumn));
            else
                fprintf("%.0f,%.0f (%d)", cell{1,i}(ibase, igroup:igroup+1), percentual(ibase,icolumn));
            end
        end
        if(ibase==sz_base)
            fprintf(" \\\\ \\hline \n");
        else
           fprintf(" \\\\ \\cline{2-%d} \n", sz_envs+2);
        end
    end
    for j=(sz_base + 1):sz_tbl
        if (j == (sz_base + 1))
            fprintf("    \\multicolumn{1}{|l|}{\\multirow{%d}{*}", (sz_tbl-sz_base));
            fprintf("{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & \\footnotesize{%s}", strategies(j));
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}", strategies(j));
        end
        icolumn = 0;
        for i=1:sz_envs
            icolumn = icolumn + 1;
            fprintf(" & ");
            if ((cell{1,i}(j, group)+cell{1,i}(j, group+1)) >= bests(icolumn))
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)", cell{1,i}(j, group:group+1), percentual(j,icolumn));
            else
                fprintf("%.0f,%.0f (%d)", cell{1,i}(j, group:group+1), percentual(j,icolumn));
            end
        end
        if (j == sz_tbl)
            fprintf(" \\\\ \\hline \n");
        else
            fprintf(" \\\\ \\cline{2-%d} \n", sz_envs+2);
        end
    end
    fprintf("  \\end{tabular}\n");
    fprintf("\\end{table*}\n");
end
