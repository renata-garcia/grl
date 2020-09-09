clc;
clear;
close all;

% %
root = config_env_os(0) + "tests_framework/";
init_size_env = 3;
% size_env = 3;
size_env = 3;
its = 1;
envs_results = cell(1,size_env);
envs_mean = [];
for it=init_size_env:size_env
    printing = 1;
    steps_counted = 20;
    runs_number = 30;
    ie=it;
    ia=1;
    withNoise = 0;
    withlimiar = 0;
    algs = ["ddpg"];
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
    [tbl_meanstd_all, percentual] = generate_tbl_article(root, printing, env, env_abr, alg, withNoise, withlimiar, steps_counted, runs_number);
    envs_results{1,ie} = tbl_meanstd_all;
    envs_mean = [envs_mean , tbl_meanstd_all(:,1:2:end)];
    
    title_leg = strcat("env= ", env, " alg= ", algs(ia));
    title_leg = strcat(title_leg, " (counted)");
%     print_article(title_leg, env_abr, tbl_meanstd_all, percentual, (it == 4))
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
% print_by_envs(title_leg, envs_results, 1, percentual)

function [tbl_meanstd_all, percentual] = generate_tbl_article(root, printing, env, env_abr, alg, withNoise, withlimiar, steps_counted, runs_number)

    if(withNoise)
        load = ["", "_noisemulti"];
    elseif (withNoise)
        disp("ERR: not load and noise");
        return;
    end

    % %
    n_env = 1;
    n_vert = 32;% 
    tbl_meanstd_all = zeros(n_vert, n_env);
    percentual = zeros(n_vert, n_env);

    if (contains(env,"cart"))
        steps_per_second = 19;
    elseif (contains(env,"pendulum"))
        steps_per_second = 33;
    elseif (contains(env,"half_cheetah"))
        steps_per_second = 100;
    else
        disp("NONE NONE");
    end
    
    runs_generic = ["1_j*.txt",...
                    "2_j*.txt",...
                    "3_j*.txt",...
                    "4_j*.txt",...
                    "5_j*.txt",...
                    "6_j*.txt",...
                    "7_j*.txt",...
                    "8_j*.txt",...
                    "9_j*.txt",...
                    "10_j*.txt",...
                    "11_j*.txt",...
                    "12_j*.txt",...
                    "13_j*.txt",...
                    "14_j*.txt",...
                    "15_j*.txt",...
                    "16_j*.txt",...
                    "17_j*.txt",...
                    "18_j*.txt",...
                    "19_j*.txt",...
                    "20_j*.txt",...
                    "21_j*.txt",...
                    "22_j*.txt",...
                    "23_j*.txt",...
                    "24_j*.txt",...
                    "25_j*.txt",...
                    "26_j*.txt",...
                    "27_j*.txt",...
                    "28_j*.txt",...
                    "29_j*.txt",...
                    "30_j*.txt",...
                    "31_j*.txt",...
                    "32_j*.txt"];

%             i_load = (ng*n_load) + ng*(il-1) + (2*ig)-1; %(ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)-1
%             j_load = (ng*n_load) + ng*(il-1) + (2*ig); %(ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)
%     i = nl*(ig-1) + 2*il -1; %(ng*n_load)*(ie-1) + 
%     j = nl*(ig-1) + 2*il;%(ng*n_load)*(ie-1) + 
    i = 1;
    j = 2;
    k = 1;
%             k = n_load*(ig-1) + il; %(ng*n_load)*(ie-1) + 
%             [tbl2, perc2] = test_take_mean_mpol(folder, env, env_abr, load(il), alg, runs_generic, printing, steps_per_second, steps_counted, runs_number, withlimiar);
    [tbl_meanstd_all(:, i:j), percentual(:,k)] = test_take_mean_mpol(root, env, env_abr, alg, runs_generic, printing, steps_per_second, steps_counted, runs_number, withlimiar) 
end


function [means_std, percentual] = test_take_mean_mpol(folder, env, env_abr, alg, runs, printing, steps_per_second, steps_counted, runs_number, withLimiar)
    subfolder = "";
    preffix = "";
    
    if (alg == "ddpg")
            subfolder = env + "_yamls_results/";
%             pendulum_pd_                     tau_replay_ddpg_tensorflow_sincos_i9_j28.yaml
            preffix = env + "_" + env_abr + "tau_replay_ddpg_tensorflow_sincos_i";
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

function print_article(caption, env_abr, tbl, percentual, hc)
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
    fprintf("  \\label{tbl_performance_online_%s}\n", env_abr);
    fprintf("  \\begin{tabular}{l|c|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|}\n");
    fprintf("    \\hline \n");
    fprintf("     \\multicolumn{2}{|c|}{} & \\multicolumn{1}{c|}{good} & \\multicolumn{1}{c|}{mid} & \\multicolumn{1}{c|}{bad} \\\\ \\hline \\hline \n");
    for j=1:sz_base
        if (j == 1)
            if (hc == 0)
                fprintf("    \\multicolumn{1}{|l|}{\\multirow{%d}{*}", sz_base);
                fprintf("{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{%s}");
            else
                fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}");
            end
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}");
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
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}");
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{%s}");
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



function print_by_envs(caption, cell, group, percentual)
    sz_envs = length(cell);
    sz_tbl = length(cell{1,1});
    igroup = group*2 -1;
    sz_base = 4;
    bests =  zeros(1, sz_envs);
    for i=1:sz_envs
    	max_base = max(cell{1,i}(1:sz_base, group));
        ind_max_base = cell{1,i}(1:sz_base, group) == max_base;
        iline = (1:sz_base)*ind_max_base;
        max_basestd = max_base - cell{1,i}(iline,igroup+1);
%         max_basestd = max_base - cell{1,i}(iline,i+1);
        bests(i) = max_basestd;
        i=i+1;
    end
    disp(bests);
    
%             \hline
%             \textbf{id} & \begin{tabular}[c]{@{}c@{}}\textbf{Inverted} \\ \textbf{Pendulum}\end{tabular} & \begin{tabular}[c]{@{}c@{}}\textbf{Cart} \\ \textbf{Pole}\end{tabular} & \begin{tabular}[c]{@{}c@{}}\textbf{Cart Double}\\ \textbf{Pole}\end{tabular} & \begin{tabular}[c]{@{}c@{}}\textbf{Half} \\ \textbf{Cheetah}\end{tabular} \\ \hline
%             \multirow{12}{*}{{\rotatebox[origin=c]{90}{\textbf{BEST}}}} & -723.88 & -280.30 & 603.34 & 1418.80 \\ \cline{2-5} 
%             & -733.34 & -337.89 & 597.49 & 1407.40 \\ \cline{2-5} 
%             & -735.07 & -361.25 & 589.37 & 1378.40 \\ \cline{2-5} 
%             & -740.93 & -387.85 & 569.46 & 1274.90 \\ \cline{2-5} 
%             & -746.33 & -456.12 & 553.90 & 1266.70 \\ \cline{2-5} 
%             & -747.98 & -457.62 & 553.40 & 1255.10 \\ \cline{2-5} 
%             & -751.91 & -461.91 & 552.58 & 1246.90 \\ \cline{2-5} 
%             & -760.58 & -475.30 & 548.09 & 1234.80 \\ \cline{2-5} 
%             & -761.32 & -694.74 & 546.31 & 1207.60 \\ \cline{2-5} 
%             & -765.48 & -699.63 & 544.65 & 1193.90 \\ \cline{2-5} 
%             & -767.78 & -707.46 & 539.81 & 1145.30 \\ \cline{2-5} 
%             & -768.47 & -716.27 & 532.98 & 1135.00 \\ \hline
%             \multirow{12}{*}{{\rotatebox[origin=c]{90}{\textbf{WORST}}}} & -3508.10 & -2,266.70 & 438.94 & 775.07 \\ \cline{2-5} 
%             & -3508.10 & -2,396.40 & 400.01 & 758.11 \\ \cline{2-5} 
%             & -3508.10 & -2,696.40 & 386.08 & 708.23 \\ \cline{2-5} 
%             & -3508.10 & -3,056.90 & 384.66 & 629.07 \\ \cline{2-5} 
%             & -3508.10 & -3,380.70 & 368.05 & 602.40 \\ \cline{2-5} 
%             & -3508.20 & -4,658.50 & 353.88 & 525.08 \\ \cline{2-5} 
%             & -3520.10 & -4,684.40 & 331.72 & 483.26 \\ \cline{2-5} 
%             & -3534.30 & -4,700.50 & 310.51 & 262.03 \\ \cline{2-5} 
%             & -3577.60 & -4,702.20 & 221.14 & 214.533 \\ \cline{2-5} 
%             & -3612.80 & -4,705.60 & 176.56 & 138.39 \\ \cline{2-5} 
%             & -4140.00 & -4,721.90 & 62.25 & -14.03 \\ \cline{2-5} 
%             & -4143.00 & -5,189.50 & 18.18 & -29.49 \\ \hline
%         \end{tabular}
%     \end{table}

    fprintf("%% Please add the following required packages to your document preamble:\n");
    fprintf("%% \\usepackage{multirow}\n");
    fprintf("  \\begin{table}[htp]\n");
    fprintf("  \\centering\n");
    fprintf("  \\scriptsize\n");
    fprintf("  \\caption{24 parametrizations chosen by environment and their performance.}\n");
    fprintf("  \\renewcommand{\\arraystretch}{1.35} %%related to vertical\n");
    fprintf("  \\label{tbl_performance_envs_16_policies}\n");
        
    fprintf("  \\begin{tabular}{|c|");
    for icolumn=1:sz_envs
        fprintf("D{,}{\\pm}{-1}|");
    end
    fprintf("}\n");
    fprintf("  \n");
    fprintf("  \n");
%continuar daqui
    
    fprintf("    \\cline{2-%d}\n", sz_envs+2);
    fprintf("     & \\multirow{1}{*}{strategy} & ");
    for icolumn=1:sz_envs
        fprintf("\\multicolumn{1}{c|}{env} & ");
    end
    fprintf("\\cline{3-%d} \\hline \n", sz_envs+2);
    for ibase=1:sz_base
        if (ibase == 1)
            fprintf("    \\multicolumn{1}{|l|}{\\multirow{%d}{*}", sz_base);
            fprintf("{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{xxxx}");
        else
            fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{xxxx}");
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
            fprintf("{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & \\footnotesize{xxxx}");
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
