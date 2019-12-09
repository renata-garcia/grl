clc;
clear;
close all;

% %
init_size_env = 1;
% size_env = 1;
size_env = 3;
it = 4;
envs_results = cell(1,size_env);
envs_mean = [];
for it=init_size_env:size_env
    printing = 0;
    steps_counted = 10;
    runs_number = 30;
    ie=it;
    ia=3;
    withLoad = 0;
    withNoise = 0;
    withlimiar = 0;
    onlybad4pend=0;
    algs = ["ac_tc", "dpg", "ddpg"];
    if (ie == 1)
        env = "pendulum"; env_abr = "pd_";
    elseif (ie == 2)
        env = "cart_pole"; env_abr = "cp_";
    elseif (ie == 3)
        env = "cart_double_pole"; env_abr = "cdp_";
    elseif (ie == 4)
        env = "half_cheetah"; env_abr = "";
    end
    alg = algs(ia);
    if (it == 4)
        [tbl_meanstd_all, percentual, strategies] = half_cheetah_gen_tbl(printing, env, env_abr, alg, withLoad, withNoise, onlybad4pend, withlimiar, steps_counted, runs_number);    
    envs_results{1,ie} = tbl_meanstd_all;
    else
        [tbl_meanstd_all, percentual, strategies] = generate_tbl_article(printing, env, env_abr, alg, withLoad, withNoise, onlybad4pend, withlimiar, steps_counted, runs_number);    
    envs_results{1,ie} = tbl_meanstd_all;
    end
    envs_mean = [envs_mean , tbl_meanstd_all(:,1:2:end)];
    
    title_leg = strcat("env= ", env, " alg= ", algs(ia));
    if (withlimiar)
        title_leg = strcat(title_leg, " limi-2500");
    else
        title_leg = strcat(title_leg, " (counted)");
    end
    if (withNoise)
        title_leg = strcat(title_leg, " NOISE AND NOT LOAAAADDD");
    end
    if (withLoad)
        title_leg = strcat(title_leg, " LOAAAADDD");
    end
    print_article(title_leg, env_abr, strategies, tbl_meanstd_all, withLoad, percentual, (it == 4))
    disp("acabou..........");
end
tbl = envs_mean;
max_tbl = max(tbl);
err = abs((max_tbl - tbl)./max_tbl);
err_good = err(:,1:3:end);
sum_err = sum(err,2);
sum_err_good = sum(err_good,2);
alg_minor_err_for = find(min(sum_err)==sum_err);
alg_minor_err_for_good = find(min(sum_err_good)==sum_err_good);
display(alg_minor_err_for);
display(alg_minor_err_for_good);
display(min(sum_err)/9);
% print_by_envs(title_leg, strategies, envs_results, 1, withLoad, percentual)

function [tbl_meanstd_all, percentual, strategies] = generate_tbl_article(printing, env, env_abr, alg, withLoad, withNoise, exc, withlimiar, steps_counted, runs_number)
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
    addpath("~/Dropbox/phd_grl_results/matlab");

    group = ["good", "mid", "bad"];
    if (exc)
        group = ["bad"];
    end

    load = "";
    if(withLoad && withNoise)
        load = ["", "_noisemulti"];
    elseif (withLoad)
        load = "_load";
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
    n_vert = 12;% 
    tbl_meanstd_all = zeros(n_vert, n_env*ng*n_load);
    percentual = zeros(n_vert, n_env*n_group*n_load);

    if (contains(env,"cart"))
        steps_per_second = 19;
    elseif (contains(env,"pendulum"))
        steps_per_second = 33;
    elseif (contains(env,"half_cheetah"))
        steps_per_second = 100;
    else
        disp("NONE NONE");
    end
    
    strategies = ["DC",...
                  "D",...
                  "M",...
                  "DCR\_MA\_B",...
                  "D\_MA\_B",...
                  "M\_ED\_MA\_B",...
                  "DCR\_MA\_25\_DC",...
                  "D\_MA\_25\_D",...
                  "M\_ED\_MA\_25\_M",...
                  "M\_ED\_MA\_25\_DC",...
                  "M\_ED\_MA\_25\_D",...
                  "DC\_ED\_MA\_25\_DC"];
              
    for ig = 1:n_group
        for il = 1:n_load                       

            runs_generic = [group(ig) + load(il) + "_*_none_none_1.0_data_center_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_density_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_mean_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_data_center_linear_order_1.0_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_1.0_best_a0.01_-*txt",... 
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.1_best_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_data_center_linear_order_0.25_data_center_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_none_density_0.25_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.25_mean_a0.01_*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.25_data_center_a0.01_*txt",...
                            group(ig) + load(il) + "_*_mean_euclidian_distance_0.25_density_a0.01_-*txt",...
                            group(ig) + load(il) + "_*_data_center_euclidian_distance_0.25_data_center_a0.01_*txt"];
                        
            i_load = (ng*n_load) + ng*(il-1) + (2*ig)-1; %(ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)-1
            j_load = (ng*n_load) + ng*(il-1) + (2*ig); %(ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)
            i = nl*(ig-1) + 2*il -1; %(ng*n_load)*(ie-1) + 
            j = nl*(ig-1) + 2*il;%(ng*n_load)*(ie-1) + 
            k = n_load*(ig-1) + il; %(ng*n_load)*(ie-1) + 
%             [tbl2, perc2] = test_take_mean_mpol(folder, env, env_abr, load(il), alg, runs_generic, printing, steps_per_second, steps_counted, runs_number, withlimiar);
            [tbl_meanstd_all(:, i:j), percentual(:,k)] = test_take_mean_mpol(folder, env, env_abr, load(il), alg, runs_generic, printing, steps_per_second, steps_counted, runs_number, withlimiar);
        end
    end
end


function [tbl_meanstd_all, percentual, strategies] = half_cheetah_gen_tbl(printing, env, env_abr, alg, withLoad, withNoise, exc, withlimiar, steps_counted, runs_number)
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
    addpath("~/Dropbox/phd_grl_results/matlab");

    group = ["good", "mid", "bad"];
    if (exc)
        group = ["bad"];
    end

    load = "";
    if(withLoad && withNoise)
        load = ["", "_noisemulti"];
    elseif (withLoad)
        load = "_load";
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
    n_vert = 3;% 
    tbl_meanstd_all = zeros(n_vert, n_env*ng*n_load);
    percentual = zeros(n_vert, n_env*n_group*n_load);

    if (contains(env,"cart"))
        steps_per_second = 19;
    elseif (contains(env,"pendulum"))
        steps_per_second = 33;
    elseif (contains(env,"half_cheetah"))
        steps_per_second = 100;
    else
        disp("NONE NONE");
    end
    
    strategies = ["DC",...
                  "D",...
                  "DC\_ED\_MA\_25\_DC"];
              
    for ig = 1:n_group
        for il = 1:n_load                       

            runs_generic = [group(ig) + load(il) + "_*_none_none_1.0_data_center_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_none_none_1.0_density_a1.0_-*txt",...
                            group(ig) + load(il) + "_*_data_center_euclidian_distance_0.25_data_center_a0.01_*txt"];
                        
            i_load = (ng*n_load) + ng*(il-1) + (2*ig)-1; %(ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)-1
            j_load = (ng*n_load) + ng*(il-1) + (2*ig); %(ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)
            i = nl*(ig-1) + 2*il -1; %(ng*n_load)*(ie-1) + 
            j = nl*(ig-1) + 2*il;%(ng*n_load)*(ie-1) + 
            k = n_load*(ig-1) + il; %(ng*n_load)*(ie-1) + 
%             [tbl2, perc2] = test_take_mean_mpol(folder, env, env_abr, load(il), alg, runs_generic, printing, steps_per_second, steps_counted, runs_number, withlimiar);
            [tbl_meanstd_all(:, i:j), percentual(:,k)] = test_take_mean_mpol(folder, env, env_abr, load(il), alg, runs_generic, printing, steps_per_second, steps_counted, runs_number, withlimiar);
        end
    end
end

function [means_std, percentual] = test_take_mean_mpol(folder, env, env_abr, load, alg, runs, printing, steps_per_second, steps_counted, runs_number, withLimiar)
    subfolder = "";
    preffix = "";
    
    if (alg == "ac_tc" || alg == "dpg")
        subfolder = env + "_mpols" + "_" + alg + load + "_yamls_results/";
        preffix = env + "_" + env_abr +"tau_" + alg + "16";
    elseif (alg == "ddpg")
        subfolder = env + "_mpols" + load + "_yamls_results/";
        preffix = env + "_" + env_abr +"tau_mpol_replay_ddpg_tensorflow_sincos_16";
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
    data_last_perf = zeros(steps_counted, length(array_runs));
    percentual = zeros(length(array_runs), 1);
    for j=1:length(array_runs)
        fd = folder + array_runs(j);
        if (printing)
            disp(fd);
        end
        
        data_no_limiar = readseries(fd, 3, 2, steps_per_second);
        if (length(data_no_limiar) < runs_number) %~=
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
            d = data(end,:);
        else
            [t, mean_d, ~, std_e] = avgseries(data_no_limiar);
            d = data_no_limiar(end,:);
        end
        hst_data = zeros(length(d),1);
        for kk=1:length(d)
            tmp = d{kk};
            hst_data(kk) = tmp(end,2);
        end
%         figure;
%         plot(1:length(d), hst_data);
%         figure;
%         histogram(transpose(hst_data));
        means_std(j, 1) = mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d)));
        means_std(j, 2) = 1.96 * mean(std_e(length(std_e)-steps_counted+1:length(std_e)));
        data_last_perf(:,j) = mean_d(length(mean_d)-steps_counted+1:length(mean_d));
    end
%     display("testing")    ;
%     for i=1:length(array_runs)
%         for j=(i+1):length(array_runs)
%             [hipotese1,pvalue] = ttest2(data_last_perf(:,i),data_last_perf(:,j),'alpha',0.01,'tail','both');
%             display(['H 99%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);
% 
%             [hipotese1,pvalue] = ttest2(data_last_perf(:,i),data_last_perf(:,j),'alpha',0.05,'tail','both');
%             display(['H 95%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
% 
%             [hipotese1,pvalue] = ttest2(data_last_perf(:,i),data_last_perf(:,j),'alpha',0.10,'tail','both');
%             display(['H 90%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
%             
%             [hipotese1,pvalue] = signrank(data_last_perf(:,i),data_last_perf(:,j),'alpha',0.10,'tail','both');
%             display(['H TP%:: i: ', num2str(i), ' - j: ', num2str(j), ' - pvalue: ', num2str(pvalue), ' - hipotese1: ', num2str(hipotese1)]);        
%             
%         end
%     end 
end

function print_article(caption, env_abr, strategies, tbl, withLoad, percentual, hc)
    sz_base = 3;
        
    j = 1;
    best_mean_base =  zeros(1, size(tbl,2)/2);
    best_std_base =  zeros(1, size(tbl,2)/2);
    for i=1:2:size(tbl,2)
        best_mean_base(j) = max(tbl(1:sz_base,i));
        ind_max = tbl(1:sz_base, i) == max(tbl(1:sz_base,i));
        best_std_base(j) = min(tbl(find(ind_max),i+1));
        j=j+1;
    end
    disp("best_mean_base &&& best_std_base")
    best_mean_base
    best_std_base
    
    j = 1;
    best_mean =  zeros(1, size(tbl,2)/2);
    std_mean =  zeros(1, size(tbl,2)/2);
    for i=1:2:size(tbl,2)
        best_mean(j) = max(tbl(:,i));
        ind_max = tbl(:, i) == max(tbl(:,i));
        std_mean(j) = min(tbl(find(ind_max),i+1));
        j=j+1;
    end
    disp("best_mean &&& max_std_best_mean")
    best_mean
    std_mean
    
    fprintf("  \\begin{table*}[]\n");
    fprintf("  \\centering\n");
    fprintf("  \\footnotesize\n");
    fprintf("  \\caption{%s}\n", caption);
    if(withLoad)
        fprintf("  \\label{tbl_performance_%s}\n", env_abr);
    else
        fprintf("  \\label{tbl_performance_online_%s}\n", env_abr);
    end
    fprintf("  \\begin{tabular}{l|c|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|}\n");
    fprintf("    \\hline \n");
    fprintf("     \\multicolumn{2}{|c|}{strategy} & \\multicolumn{1}{c|}{good} & \\multicolumn{1}{c|}{mid} & \\multicolumn{1}{c|}{bad} \\\\ \\hline \\hline \n");
    for j=1:sz_base
        if (j == 1)
            if (hc == 0)
                fprintf("    \\multicolumn{1}{|l|}{\\multirow{%d}{*}", sz_base);
                fprintf("{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{%s}", strategies(j));
            else
                fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}", strategies(j));
            end
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}", strategies(j));
        end
        k = 1;
        ii = 0;
        for i=1:2:size(tbl,2)
            ii = ii + 1;
            k = ii;
            fprintf(" & ");
            if ( tbl(j, i) >= (best_mean(k) - std_mean(k)) )
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)\\textbf{*}", tbl(j, i:i+1), percentual(j,ii));
            elseif ((tbl(j, i) >= best_mean_base(k) - best_std_base(k)) && (tbl(j, i) >= best_mean_base(k) - best_std_base(k)) )
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)", tbl(j, i:i+1), percentual(j,ii));
            elseif ( tbl(j, i) >= (best_mean_base(k)-best_std_base(k)) )
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)", tbl(j, i:i+1), percentual(j,ii));
            else
                fprintf("%.0f,%.0f (%d)", tbl(j, i:i+1), percentual(j,ii));
            end
        end
        if(j==sz_base)
            fprintf(" \\\\ \\hline \\hline \n");
        else
           fprintf(" \\\\ \\cline{2-5} \n");
        end
        
    end
    for j=(sz_base + 1):size(tbl, 1)
        if (j == (sz_base + 1))
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}", strategies(j));
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}", strategies(j));
        end
        ii = 0;
        for i=1:2:size(tbl,2)
            ii = ii + 1;
            k = ii;
            fprintf(" & ");
            if ( tbl(j, i) >= (best_mean(k) - std_mean(k)) )
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)\\textbf{*}", tbl(j, i:i+1), percentual(j,ii));
            elseif ((tbl(j, i) >= best_mean_base(k) - best_std_base(k)) && (tbl(j, i) >= best_mean_base(k) - best_std_base(k)) )
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)", tbl(j, i:i+1), percentual(j,ii));
            elseif ( tbl(j, i) >= (best_mean_base(k)-best_std_base(k)) )
                fprintf("\\textbf{%.0f},\\textbf{%.0f} (%d)", tbl(j, i:i+1), percentual(j,ii));
            else
                fprintf("%.0f,%.0f (%d)", tbl(j, i:i+1), percentual(j,ii));
            end
        end
        if ((j == size(tbl, 1)) || (rem(j,3) == 0))
            fprintf(" \\\\ \\hline \\hline \n");
        else
            fprintf(" \\\\ \\cline{2-5} \n");
        end
    end
    fprintf("  \\end{tabular}\n");
    fprintf("\\end{table*}\n");
end

