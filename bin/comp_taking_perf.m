clc;
clear;
close all;

% %
for ica=3:3
    printing = 0;
    steps_counted = 10;
    ie=1;
    ia=ica
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
    [tbl_meanstd_all, percentual] = generate_tbl(printing, env, env_abr, alg, withLoad, withNoise, onlybad4pend, withlimiar);
    title_leg = strcat("env= ", env, " alg= ", algs(ia));
    if (withlimiar)
        title_leg = strcat(title_leg, " limi-3500");
    end
    if (withNoise)
        title_leg = strcat(title_leg, " NOISE AND NOT LOAAAADDD");
    end
    print(title_leg, tbl_meanstd_all, withLoad, percentual)
    disp("acabou..........");
end

function [tbl_meanstd_all, percentual] = generate_tbl(printing, env, env_abr, alg, withLoad, withNoise, exc, withlimiar)
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
    n_vert = 23; %12; %
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
                            group(ig) + load(il) + "_*_none_density_linear_order_0.5_density_a0.01_-*txt"]; 
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
                if (mean(tmp((end-5):end,2)) > -3500)
                    k = k + 1;
                    data{k} = data_no_limiar{i};
                    percentual(j) = percentual(j) + 1;
                end
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

function test_printL_1env_tbl_all_std_perc(caption, tbl, withLoad, percentual)
    sz_base = 4;
    ind_max = 1;
    jmp_grp = 2;
    if(withLoad)
        ind_max = 3;
        jmp_grp = 4;
    end
    bests =  zeros(1, 3);
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
                  "DLO\_MA\_50\_D"];
              
              
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
            k = 1 + floor(i/jmp_grp);
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
            k = 1 + floor(i/jmp_grp);
            fprintf(" & ");
            if ((tbl(j, i)-tbl(j, i+1)) >= bests(k))
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

function print(caption, tbl, withLoad, percentual)
    sz_base = 4;
    ind_max = 1;
    jmp_grp = 2;
%     if(withLoad)
%         ind_max = 3;
%         jmp_grp = 4;
%     end
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
                  "DLO\_MA\_50\_D"];
              
              
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
%             k = 1 + floor(i/jmp_grp);
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
%             k = 1 + floor(i/jmp_grp);
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
