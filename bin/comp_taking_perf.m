clc;
clear;
close all;

% % 
steps_counted = 10;
% test_cartpole();
ie=2;
ia=1;
if (ie == 1)
    env = "pendulum"; env_abr = "pd";
elseif (ie == 2)
    env = "cart_pole"; env_abr = "cp";
end
algs = ["ac_tc", "dpg", "ddpg"];
alg = algs(ia);
tbl_meanstd_all = generate_tbl(env, env_abr, alg);
title_leg = strcat("env= ", env, " alg= ", algs(ia));
test_printL_1env_tbl_all_std(title_leg, tbl_meanstd_all)
% [perf_good, perf_mid, perf_bad, perf_stdgood, perf_stdmid, perf_stdbad, bpd, bstdpd, bcp, bstdcp, bcdp, bstdcdp] = generate_tables(steps_counted);

function [perf_good, perf_mid, perf_bad, perf_stdgood, perf_stdmid, perf_stdbad, bpd, bstdpd, bcp, bstdcp, bcdp, bstdcdp] = generate_tables(steps_counted)
    printing = 0;
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
    addpath("~/Dropbox/phd_grl_results/matlab");

    tbl_mean_all = zeros(12, 6*3);
    tbl_std_all = zeros(12, 6*3);

    for i=1:3
        if (i == 1)
            env = "pendulum"; env_abr = "pd";
        elseif (i == 2)
            env = "cart_pole"; env_abr = "cp";
        elseif (i == 3)
            env = "cart_double_pole"; env_abr = "cdp";
        end

        if (contains(env,"cart"))
            steps_per_second = 20;
        elseif (contains(env,"pendulum"))
            steps_per_second = 33;
        else
            disp("NONE NONE");
        end

        type = "good";
        [tbl_mean_all(:, 6*(i-1) + 1), tbl_std_all(:, 6*(i-1) + 1)] = take_mean_mpol(folder, type, "_load", env, env_abr, printing, steps_per_second, steps_counted);
        [tbl_mean_all(:, 6*(i-1) + 2), tbl_std_all(:, 6*(i-1) + 2)] = take_mean_mpol(folder, type, "", env, env_abr, printing, steps_per_second, steps_counted);

        type = "mid";
        [tbl_mean_all(:, 6*(i-1) + 3), tbl_std_all(:, 6*(i-1) + 3)] = take_mean_mpol(folder, type, "_load", env, env_abr, printing, steps_per_second, steps_counted);
        [tbl_mean_all(:, 6*(i-1) + 4),tbl_std_all(:, 6*(i-1) + 4)] = take_mean_mpol(folder, type, "", env, env_abr, printing, steps_per_second, steps_counted);

        type = "bad";
        [tbl_mean_all(:, 6*(i-1) + 5),tbl_std_all(:, 6*(i-1) + 5)] = take_mean_mpol(folder, type, "_load", env, env_abr, printing, steps_per_second, steps_counted);
        [tbl_mean_all(:, 6*(i-1) + 6),tbl_std_all(:, 6*(i-1) + 6)] = take_mean_mpol(folder, type, "", env, env_abr, printing, steps_per_second, steps_counted);
    end

    pd_good = tbl_mean_all(:, 1:2);
    pd_mid = tbl_mean_all(:, 3:4);
    pd_bad = tbl_mean_all(:, 5:6);
    cp_good = tbl_mean_all(:, 7:8);
    cp_mid = tbl_mean_all(:, 9:10);
    cp_bad = tbl_mean_all(:, 11:12);
    cdp_good = tbl_mean_all(: , 13:14);
    cdp_mid = tbl_mean_all(: , 15:16);
    cdp_bad = tbl_mean_all(: , 17:18);
    perf_good = [pd_good,cp_good,cdp_good];
    perf_mid = [pd_mid,cp_mid,cdp_mid];
    perf_bad = [pd_bad,cp_bad,cdp_bad];

    stdpd_good = tbl_std_all(:, 1:2);
    stdpd_mid = tbl_std_all(:, 3:4);
    stdpd_bad = tbl_std_all(:, 5:6);
    stdcp_good = tbl_std_all(:, 7:8);
    stdcp_mid = tbl_std_all(:, 9:10);
    stdcp_bad = tbl_std_all(:, 11:12);
    stdcdp_good = tbl_std_all(: , 13:14);
    stdcdp_mid = tbl_std_all(: , 15:16);
    stdcdp_bad = tbl_std_all(: , 17:18);
    perf_stdgood = [stdpd_good,stdcp_good,stdcdp_good];
    perf_stdmid = [stdpd_mid,stdcp_mid,stdcdp_mid];
    perf_stdbad = [stdpd_bad,stdcp_bad,stdcdp_bad];
    
    [bpd, bstdpd] = take_mean(folder+"replay_ddpg_tensorflow_sincos_*txt", printing, steps_per_second, steps_counted);
    [bcp, bstdcp] = take_mean(folder+"cartpole_mpol_1_replay_ddpg_tensorflow_replay_steps_128_batch_size_64_reward_010_*txt", printing, steps_per_second, steps_counted);
    [bcdp, bstdcdp] = take_mean(folder+"cart_double_pole_mpol_1_replay_ddpg_tensorflow_*txt", printing, steps_per_second, steps_counted);

    print_tbl_good_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, cp_good, cdp_good);
    print_tbl_good_std_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, cp_good, cdp_good, stdpd_good, stdcp_good, stdcdp_good, bpd, bstdpd, bcp, bstdcp, bcdp, bstdcdp);
    print_tbl_all_std_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, cp_good, cdp_good, stdpd_good, stdcp_good, stdcdp_good, pd_mid, cp_mid, cdp_mid, stdpd_mid, stdcp_mid, stdcdp_mid, pd_bad, cp_bad, cdp_bad, stdpd_bad, stdcp_bad, stdcdp_bad);
    
    disp(tbl_mean_all);
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [means, std] = take_mean(array_runs, printing, steps_per_second, steps_counted)
    fd = array_runs;
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_d] = avgseries(readseries(fd, 3, 2, steps_per_second));

%     fprintf('i: %.0f, ',length(mean_d)-steps_counted+1);
%     fprintf('length: %.0f\n',length(mean_d));

    means = zeros(length(array_runs), 1);
    std = zeros(length(array_runs), 1);
    for j=1:length(array_runs)
        fd = array_runs;
        if (printing)
            disp(fd);
        end
        [t, mean_d, ~, std_d] = avgseries(readseries(fd, 3, 2, steps_per_second));
        means(j) = mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d)));
        std(j) = mean(std_d(length(std_d)-steps_counted+1:length(std_d)));
%         fprintf("%.0f \n", means(j));
    end
end

function [means, std] = take_mean_mpol(folder, type, load, env, env_abr, printing, steps_per_second, steps_counted)
    subfolder = env + "_mpols" + load + "_yamls_results/";
    preffix = env + "_" + env_abr +"_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + load;

        array_runs = [subfolder + preffix + "_*_none_none_1.0_density_a1.0_*txt",...
                      subfolder + preffix + "_*_none_none_1.0_data_center_a1.0_*txt",...
                      subfolder + preffix + "_*_none_none_1.0_mean_a1.0_*txt",...
                      subfolder + preffix + "_*_none_none_1.0_random_a1_*txt",...
                      subfolder + preffix + "_*_none_density_0.5_density_a0.01_*txt",...
                      subfolder + preffix + "_*_none_density_0.5_data_center_a0.01_*txt",...
                      subfolder + preffix + "_*_none_density_1.0_best_a0.01_*txt",...
                      subfolder + preffix + "_*_density_euclidian_distance_0.01_best_a0.01_*txt",...
                      subfolder + preffix + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                      subfolder + preffix + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                      subfolder + preffix + "_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt",...
                      subfolder + preffix + "_*_mean_euclidian_distance_0.1_best_a0.01_*txt"];

    fd = folder + array_runs(1);
    if (printing)
        disp(fd);
    end
    [t, mean_d, ~, std_d] = avgseries(readseries(fd, 3, 2, steps_per_second));

%     fprintf('i: %.0f, ',length(mean_d)-steps_counted+1);
%     fprintf('length: %.0f\n',length(mean_d));

    means = zeros(length(array_runs), 1);
    std = zeros(length(array_runs), 1);
    for j=1:length(array_runs)
        fd = folder + array_runs(j);
        if (printing)
            disp(fd);
        end
        [t, mean_d, ~, std_d] = avgseries(readseries(fd, 3, 2, steps_per_second));
        means(j) = mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d)));
        std(j) = mean(std_d(length(std_d)-steps_counted+1:length(std_d)));
%         fprintf("%.0f \n", means(j));
    end
end

function print_tbl_good_latex(caption, pd, cp, cdp)
	fprintf("%% Please add the following required packages to your document preamble:\n");
    fprintf("%% \\usepackage{multirow}\n");
    fprintf("  \\begin{table*}[]\n");
    fprintf("  \\centering\n");
    fprintf("  \\caption{%s}\n", caption);
    fprintf("  \\label{tab_performance_base_new}\n");
    fprintf("  \\begin{tabular}{l|c|c|c|c|c|c|c|}\n");
    fprintf("    \\cline{2-8}\n");
    fprintf("     & strategy & \\multicolumn{2}{c|}{pendulum} & \\multicolumn{2}{c|}{cart pole} & \\multicolumn{2}{c|}{cart double pole} \\\\ \\cline{3-8} \n");
    fprintf("     &  & learned & learning & learned & learning & learned & learning \\\\ \\hline\n");
    fprintf("    \\multicolumn{1}{|l|}{\\multirow{4}{*}{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & D & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(1,1), pd(1,2), cp(1,1), cp(1,2), cdp(1,1), cdp(1,2));
    fprintf("    \\multicolumn{1}{|l|}{} & DC & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(2,1), pd(2,2), cp(2,1), cp(2,2), cdp(2,1), cdp(2,2));
    fprintf("    \\multicolumn{1}{|l|}{} & M & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(3,1), pd(3,2), cp(3,1), cp(3,2), cdp(3,1), cdp(3,2));
    fprintf("    \\multicolumn{1}{|l|}{} & RND & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\hline\n", pd(4,1), pd(4,2), cp(4,1), cp(4,2), cdp(4,1), cdp(4,2));
    fprintf("    \\multicolumn{1}{|l|}{\\multirow{8}{*}{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & D\\_MA\\_50\\_D & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(5,1), pd(5,2), cp(5,1), cp(5,2), cdp(5,1), cdp(5,2));
    fprintf("    \\multicolumn{1}{|l|}{} & D\\_MA\\_50\\_DC & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(6,1), pd(6,2), cp(6,1), cp(6,2), cdp(6,1), cdp(6,2));
    fprintf("    \\multicolumn{1}{|l|}{} & D\\_MA\\_B & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(7,1), pd(7,2), cp(7,1), cp(7,2), cdp(7,1), cdp(7,2));
    fprintf("    \\multicolumn{1}{|l|}{} & D\\_ED\\_MA\\_B & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(8,1), pd(8,2), cp(8,1), cp(8,2), cdp(8,1), cdp(8,2));
    fprintf("    \\multicolumn{1}{|l|}{} & DC\\_MA\\_B & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(9,1), pd(9,2), cp(9,1), cp(9,2), cdp(9,1), cdp(9,2));
    fprintf("    \\multicolumn{1}{|l|}{} & M\\_ED\\_MA\\_50\\_D & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(10,1), pd(10,2), cp(10,1), cp(10,2), cdp(10,1), cdp(10,2));
    fprintf("    \\multicolumn{1}{|l|}{} & M\\_ED\\_MA\\_50\\_DC & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\cline{2-8} \n", pd(11,1), pd(11,2), cp(11,1), cp(11,2), cdp(11,1), cdp(11,2));
    fprintf("    \\multicolumn{1}{|l|}{} & M\\_ED\\_MA\\_B & %.0f & %.0f & %.0f & %.0f & %.0f & %.0f \\\\ \\hline\n", pd(12,1), pd(12,2), cp(12,1), cp(12,2), cdp(12,1), cdp(12,2));
    fprintf("  \\end{tabular}\n");
    fprintf("\\end{table*}\n");
end

function print_tbl_good_std_latex(caption, pd, cp, cdp, stdpd, stdcp, stdcdp, bpd, bstdpd, bcp, bstdcp, bcdp, bstdcdp)
    tmp = pd(1:4,:);
    up_pd = [ max(pd(1:4,:)) + stdpd( find(pd(1:4,1)==max(pd(1:4,:))) )]
    down_pd = [ max(pd(1:4,:)) - stdpd( find(pd(1:4,1)==max(pd(1:4,:))) )]
    up_cp = bcp + bstdcp;
    down_cp = bcp - bstdcp;
    up_cdp = bcdp + bstdcdp;
    down_cdp = bcdp - bstdcdp;
    fprintf("%% Please add the following required packages to your document preamble:\n");
    fprintf("%% \\usepackage{multirow}\n");
    fprintf("  \\begin{table*}[]\n");
    fprintf("  \\centering\n");
    fprintf("  \\footnotesize\n");
    fprintf("  \\caption{%s}\n", caption);
    fprintf("  \\label{tab_performance_base_new}\n");
    fprintf("  \\begin{tabular}{l|c|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{4.4}|}\n");
    fprintf("    \\cline{2-8}\n");
    fprintf("     & \\multirow{2}{*}{strategy} & \\multicolumn{2}{c|}{pendulum} & \\multicolumn{2}{c|}{cart pole} & \\multicolumn{2}{c|}{cart double pole} \\\\ \\cline{3-8} \n");
    fprintf("     &  & \\multicolumn{1}{|c|}{learned} & \\multicolumn{1}{|c|}{learning} & \\multicolumn{1}{|c|}{learned} & \\multicolumn{1}{|c|}{learning} & \\multicolumn{1}{|c|}{learned} & \\multicolumn{1}{|c|}{learning} \\\\ \\hline\n");
    
    fprintf("    \\multicolumn{1}{|l|}{\\multirow{4}{*}{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{D} & ");
    fprinttex(pd(1,1:2), stdpd(1,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(1,1:2), stdcp(1,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(1,1:2), stdcdp(1,1:2), up_cdp, down_cdp)
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC} & ");
    fprinttex(pd(2,1:2), stdpd(2,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(2,1:2), stdcp(2,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(2,1:2), stdcdp(2,1:2), up_cdp, down_cdp)
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M} & ");
    fprinttex(pd(3,1:2), stdpd(3,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(3,1:2), stdcp(3,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(3,1:2), stdcdp(3,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{RND} & ");
    fprinttex(pd(4,1:2), stdpd(4,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(4,1:2), stdcp(4,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(4,1:2), stdcdp(4,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\hline\n");
    fprintf("    \\multicolumn{1}{|l|}{\\multirow{8}{*}{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & \\footnotesize{D\\_MA\\_50\\_D} & ");
    fprinttex(pd(5,1:2), stdpd(5,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(5,1:2), stdcp(5,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(5,1:2), stdcdp(5,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_MA\\_50\\_DC} & ");
    fprinttex(pd(6,1:2), stdpd(6,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(6,1:2), stdcp(6,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(6,1:2), stdcdp(6,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_MA\\_B} & ");
    fprinttex(pd(7,1:2), stdpd(7,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(7,1:2), stdcp(7,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(7,1:2), stdcdp(7,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_ED\\_MA\\_B} & ");
    fprinttex(pd(8,1:2), stdpd(8,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(8,1:2), stdcp(8,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(8,1:2), stdcdp(8,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC\\_MA\\_B} & ");
    fprinttex(pd(9,1:2), stdpd(9,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(9,1:2), stdcp(9,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(9,1:2), stdcdp(9,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_50\\_D} & ");
    fprinttex(pd(10,1:2), stdpd(10,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(10,1:2), stdcp(10,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(10,1:2), stdcdp(10,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_50\\_DC} & ");
    fprinttex(pd(11,1:2), stdpd(11,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(11,1:2), stdcp(11,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(11,1:2), stdcdp(11,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\cline{2-8} \n");
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_B} & ");
    fprinttex(pd(12,1:2), stdpd(12,1:2), up_pd, down_pd); fprintf(" & ");
    fprinttex(cp(12,1:2), stdcp(12,1:2), up_cp, down_cp); fprintf(" & ");
    fprinttex(cdp(12,1:2), stdcdp(12,1:2), up_cdp, down_cdp);
    fprintf(" \\\\ \\hline\n");
    fprintf("  \\end{tabular}\n");
    fprintf("\\end{table*}\n");
end

function print_tbl_all_std_latex(caption, pd_good, cp_good, cdp_good, stdpd_good, stdcp_good, stdcdp_good, pd_mid, cp_mid, cdp_mid, stdpd_mid, stdcp_mid, stdcdp_mid, pd_bad, cp_bad, cdp_bad, stdpd_bad, stdcp_bad, stdcdp_bad)
	fprintf("%% Please add the following required packages to your document preamble:\n");
    fprintf("%% \\usepackage{multirow}\n");
    fprintf("  \\begin{table*}[]\n");
    fprintf("  \\centering\n");
    fprintf("  \\footnotesize\n");
    fprintf("  \\caption{%s}\n", caption);
    fprintf("  \\label{tab_performance_all}\n");
    fprintf("  \\begin{tabular}{l|c|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{4.4}|}\n");
    fprintf("    \\cline{2-11}\n");
    fprintf("     & \\multirow{2}{*}{strategy} & \\multicolumn{3}{c|}{pendulum} & \\multicolumn{3}{c|}{cart pole} & \\multicolumn{3}{c|}{cart double pole} \\\\ \\cline{3-11} \n");
    fprintf("     &  & \\multicolumn{1}{|c|}{good} & \\multicolumn{1}{|c|}{mid} & \\multicolumn{1}{|c|}{bad} & \\multicolumn{1}{|c|}{good} & \\multicolumn{1}{|c|}{mid} & \\multicolumn{1}{|c|}{bad} & \\multicolumn{1}{|c|}{good} & \\multicolumn{1}{|c|}{mid} & \\multicolumn{1}{|c|}{bad} \\\\ \\hline\n");
    fprintf("    \\multicolumn{1}{|l|}{\\multirow{4}{*}{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{D}"+...
		" & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(1,2), stdpd_good(1,2), pd_mid(1,2), stdpd_mid(1,2), pd_bad(1,2), stdpd_bad(1,2), cp_good(1,2), stdcp_good(1,2), cp_mid(1,2), stdcp_mid(1,2), cp_bad(1,2), stdcp_bad(1,2), cdp_good(1,2), stdcdp_good(1,2), cdp_mid(1,2), stdcdp_mid(1,2), cdp_bad(1,2), stdcdp_bad(1,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC}"+...
	" & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(2,2), stdpd_good(2,2), pd_mid(2,2), stdpd_mid(2,2), pd_bad(2,2), stdpd_bad(2,2), cp_good(2,2), stdcp_good(2,2), cp_mid(2,2), stdcp_mid(2,2), cp_bad(2,2), stdcp_bad(2,2), cdp_good(2,2), stdcdp_good(2,2), cdp_mid(2,2), stdcdp_mid(2,2), cdp_bad(2,2), stdcdp_bad(2,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(3,2), stdpd_good(3,2), pd_mid(3,2), stdpd_mid(3,2), pd_bad(3,2), stdpd_bad(3,2), cp_good(3,2), stdcp_good(3,2), cp_mid(3,2), stdcp_mid(3,2), cp_bad(3,2), stdcp_bad(3,2), cdp_good(3,2), stdcdp_good(3,2), cdp_mid(3,2), stdcdp_mid(3,2), cdp_bad(3,2), stdcdp_bad(3,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{RND} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\hline\n",...
		pd_good(4,2), stdpd_good(4,2), pd_mid(4,2), stdpd_mid(4,2), pd_bad(4,2), stdpd_bad(4,2), cp_good(4,2), stdcp_good(4,2), cp_mid(4,2), stdcp_mid(4,2), cp_bad(4,2), stdcp_bad(4,2), cdp_good(4,2), stdcdp_good(4,2), cdp_mid(4,2), stdcdp_mid(4,2), cdp_bad(4,2), stdcdp_bad(4,2));
    fprintf("    \\multicolumn{1}{|l|}{\\multirow{8}{*}{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & \\footnotesize{D\\_MA\\_50\\_D}"+...
		" & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(5,2), stdpd_good(5,2), pd_mid(5,2), stdpd_mid(5,2), pd_bad(5,2), stdpd_bad(5,2), cp_good(5,2), stdcp_good(5,2), cp_mid(5,2), stdcp_mid(5,2), cp_bad(5,2), stdcp_bad(5,2), cdp_good(5,2), stdcdp_good(5,2), cdp_mid(5,2), stdcdp_mid(5,2), cdp_bad(5,2), stdcdp_bad(5,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_MA\\_50\\_DC} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(6,2), stdpd_good(6,2), pd_mid(6,2), stdpd_mid(6,2), pd_bad(6,2), stdpd_bad(6,2), cp_good(6,2), stdcp_good(6,2), cp_mid(6,2), stdcp_mid(6,2), cp_bad(6,2), stdcp_bad(6,2), cdp_good(6,2), stdcdp_good(6,2), cdp_mid(6,2), stdcdp_mid(6,2), cdp_bad(6,2), stdcdp_bad(6,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_MA\\_B} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(7,2), stdpd_good(7,2), pd_mid(7,2), stdpd_mid(7,2), pd_bad(7,2), stdpd_bad(7,2), cp_good(7,2), stdcp_good(7,2), cp_mid(7,2), stdcp_mid(7,2), cp_bad(7,2), stdcp_bad(7,2), cdp_good(7,2), stdcdp_good(7,2), cdp_mid(7,2), stdcdp_mid(7,2), cdp_bad(7,2), stdcdp_bad(7,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_ED\\_MA\\_B} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(8,2), stdpd_good(8,2), pd_mid(8,2), stdpd_mid(8,2), pd_bad(8,2), stdpd_bad(8,2), cp_good(8,2), stdcp_good(8,2), cp_mid(8,2), stdcp_mid(8,2), cp_bad(8,2), stdcp_bad(8,2), cdp_good(8,2), stdcdp_good(8,2), cdp_mid(8,2), stdcdp_mid(8,2), cdp_bad(8,2), stdcdp_bad(8,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC\\_MA\\_B} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(9,2), stdpd_good(9,2), pd_mid(9,2), stdpd_mid(9,2), pd_bad(9,2), stdpd_bad(9,2), cp_good(9,2), stdcp_good(9,2), cp_mid(9,2), stdcp_mid(9,2), cp_bad(9,2), stdcp_bad(9,2), cdp_good(9,2), stdcdp_good(9,2), cdp_mid(9,2), stdcdp_mid(9,2), cdp_bad(9,2), stdcdp_bad(9,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_50\\_D} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(10,2), stdpd_good(10,2), pd_mid(10,2), stdpd_mid(10,2), pd_bad(10,2), stdpd_bad(10,2), cp_good(10,2), stdcp_good(10,2), cp_mid(10,2), stdcp_mid(10,2), cp_bad(10,2), stdcp_bad(10,2), cdp_good(10,2), stdcdp_good(10,2), cdp_mid(10,2), stdcdp_mid(10,2), cdp_bad(10,2), stdcdp_bad(10,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_50\\_DC} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
		pd_good(11,2), stdpd_good(11,2), pd_mid(11,2), stdpd_mid(11,2), pd_bad(11,2), stdpd_bad(11,2), cp_good(11,2), stdcp_good(11,2), cp_mid(11,2), stdcp_mid(11,2), cp_bad(11,2), stdcp_bad(11,2), cdp_good(11,2), stdcdp_good(11,2), cdp_mid(11,2), stdcdp_mid(11,2), cdp_bad(11,2), stdcdp_bad(11,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_B} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\hline\n",...
		pd_good(12,2), stdpd_good(12,2), pd_mid(12,2), stdpd_mid(12,2), pd_bad(12,2), stdpd_bad(12,2), cp_good(12,2), stdcp_good(12,2), cp_mid(12,2), stdcp_mid(12,2), cp_bad(12,2), stdcp_bad(12,2), cdp_good(12,2), stdcdp_good(12,2), cdp_mid(12,2), stdcdp_mid(12,2), cdp_bad(12,2), stdcdp_bad(12,2));
    fprintf("  \\end{tabular}\n");
    fprintf("\\end{table*}\n");
end

function fprinttex(v, s, up, down)
    if (v < down)
        fprintf("%.0f,%.0f & %.0f,%.0f", v(1), s(1), v(2), s(2));
    else
        fprintf("\\textbf{%.0f},\\textbf{%.0f} & \\textbf{%.0f},\\textbf{%.0f}", v(1), s(1), v(2), s(2));
    end
end

function tbl_meanstd_all = generate_tbl(env, env_abr, alg)
    steps_counted = 10;
    printing = 1;
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
    addpath("~/Dropbox/phd_grl_results/matlab");

    group = ["good", "mid", "bad"];
    load = ["", "_load"];
    load = [""];
    n_group = length(group);
    n_load = length(load);
    ng = 2*n_group;
    nl = 2*n_load;

    % %
    n_env = 1;
    tbl_meanstd_all = zeros(24, n_env*ng*n_load);

    for ie = 1:n_env

        if (contains(env,"cart"))
            steps_per_second = 20;
        elseif (contains(env,"pendulum"))
            steps_per_second = 33;
        else
            disp("NONE NONE");
        end

        for ig = 1:n_group
            for il = 1:n_load
                runs_generic = [group(ig) + load(il) + "_*_none_none_1.0_data_center_a1.0_*txt",...
                                group(ig) + load(il) + "_*_none_none_1.0_density_a1.0_*txt",...
                                group(ig) + load(il) + "_*_none_none_1.0_mean_a1.0_*txt",...
                                group(ig) + load(il) + "_*_none_none_1.0_random_a1_*txt",...
                                group(ig) + load(il) + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                                group(ig) + load(il) + "_*_none_data_center_linear_order_0.25_data_center_a0.01*txt",...
                                group(ig) + load(il) + "_*_none_data_center_linear_order_0.5_data_center_a0.01*txt",...
                                group(ig) + load(il) + "_*_none_data_center_linear_order_0.75_data_center_a0.01*txt",...
                                group(ig) + load(il) + "_*_none_data_center_linear_order_0.5_density_a0.01*txt",...
                                group(ig) + load(il) + "_*_none_density_0.5_density_a0.01_*txt",...
                                group(ig) + load(il) + "_*_none_density_0.5_data_center_a0.01_*txt",...
                                group(ig) + load(il) + "_*_none_density_1.0_best_a0.01_*txt",...
                                group(ig) + load(il) + "_*_data_center_euclidian_distance_0.25_data_center_a0.01_*txt",...
                                group(ig) + load(il) + "_*_data_center_euclidian_distance_0.5_data_center_a0.01*txt",...
                                group(ig) + load(il) + "_*_data_center_euclidian_distance_0.75_data_center_a0.01*txt",...
                                group(ig) + load(il) + "_*_data_center_euclidian_distance_0.1_best_a0.01*txt",...
                                group(ig) + load(il) + "_*_density_euclidian_distance_0.01_best_a0.01_*txt",...
                                group(ig) + load(il) + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                                group(ig) + load(il) + "_*_mean_euclidian_distance_0.1_best_a0.01*txt",...
                                group(ig) + load(il) + "_*_mean_euclidian_distance_0.25_density_a0.01*txt",...
                                group(ig) + load(il) + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                                group(ig) + load(il) + "_*_mean_euclidian_distance_0.75_density_a0.01_*txt",...
                                group(ig) + load(il) + "_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt",...
                                group(ig) + load(il) + "_*_none_density_linear_order_0.5_density_a0.01*txt"];
                i_load = (ng*n_load)*(ie-1) + ng*(il-1) + (2*ig)-1;
                j_load = (ng*n_load)*(ie-1) + ng*(il-1) + (2*ig);
                i = (ng*n_load)*(ie-1) + nl*(ig-1) + 2*il -1;
                j = (ng*n_load)*(ie-1) + nl*(ig-1) + 2*il;
                [tbl_meanstd_all(:, i:j)] = test_take_mean_mpol(folder, env, env_abr, load(il), alg, runs_generic, printing, steps_per_second, steps_counted);
            end
        end

%     type = "good";
%     runs_specific_good = ["r25" + type + "_*_mean_euclidian_distance_0.25_density_a0.01_*.txt",...
%                           "r05" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%                           "r25" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%                           "r50" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%                                   type + "_*_none_density_linear_order_0.1_best_a0.01_*.txt",...
%                                   type + "_*_none_density_linear_order_0.5_data_center_a0.01_*.txt",...
%                                   type + "_*_none_density_linear_order_0.5_density_a0.01_*.txt"];
%     tbl_meanstd_specific_good = test_take_mean_mpol(folder, env, env_abr, "", runs_specific_good, printing, steps_per_second, steps_counted);
% 
%     type = "mid";
%     runs_specific_mid = [         type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%                           "r05" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%                           "r25" + type + "_*_mean_euclidian_distance_0.25_density_a0.01_*.txt",...
%                           "r25" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt"];
%     tbl_meanstd_specific_mid = test_take_mean_mpol(folder, env, env_abr, "", runs_specific_mid, printing, steps_per_second, steps_counted);
% 
%     type = "bad";
%     runs_specific_bad = [         type + "_*_none_data_center_linear_order_0.25_data_center_a0.01_*txt",...
%                                   type + "_*_none_data_center_linear_order_0.5_data_center_a0.01_*txt",...
%                                   type + "_*_none_data_center_linear_order_0.75_data_center_a0.01_*txt",...
%                                   type + "_*_none_data_center_linear_order_0.5_density_a0.01_*txt",...
%                                   type + "_*_data_center_euclidian_distance_0.1_best_a0.01_*txt",...
%                                   type + "_*_data_center_euclidian_distance_0.1_best_a0.02_*txt",...
%                                   type + "_*_data_center_euclidian_distance_0.25_data_center_a0.01_*.txt",...
%                                   type + "_*_data_center_euclidian_distance_0.5_data_center_a0.005_*.txt",...
%                                   type + "_*_data_center_euclidian_distance_0.5_data_center_a0.01_*.txt",...
%                                   type + "_*_data_center_euclidian_distance_0.5_data_center_a0.02_*.txt",...
%                                   type + "_*_data_center_euclidian_distance_0.75_data_center_a0.01_*.txt",...
%                                   type + "_*_mean_euclidian_distance_0.25_density_a0.01_*.txt",...
%                                   type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%                           "r05" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%                           "r25" + type + "_*_mean_euclidian_distance_0.25_density_a0.01_*.txt",...
%                           "r25" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt",...
%                           "r50" + type + "_*_mean_euclidian_distance_0.5_density_a0.01_*.txt"];
%     tbl_meanstd_specific_bad = test_take_mean_mpol(folder, env, env_abr, "", runs_specific_bad, printing, steps_per_second, steps_counted);
    end
% print_tbl_good_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good);
% print_tbl_good_std_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, stdpd_good, bpd, bstdpd);
% print_tbl_all_std_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, stdpd_good, pd_mid, stdpd_mid, pd_bad, stdpd_bad);

disp(tbl_meanstd_all);
% disp(tbl_meanstd_specific_good);
% disp(tbl_meanstd_specific_mid);
% disp(tbl_meanstd_specific_bad);
end

function means_std = test_take_mean_mpol(folder, env, env_abr, load, alg, runs, printing, steps_per_second, steps_counted)
    subfolder = "";
    preffix = "";
    
    if (alg == "ac_tc" || alg == "dpg")
        subfolder = env + "_mpols" + "_" + alg + load + "_yamls_results/";
        preffix = env + "_" + env_abr +"_tau_ac_tc16";
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
    [t, mean_d, ~, std_d] = avgseries(readseries(fd, 3, 2, steps_per_second));

    means_std = zeros(length(array_runs), 2);
    for j=1:length(array_runs)
        fd = folder + array_runs(j);
        if (printing)
            disp(fd);
        end
        [t, mean_d, ~, std_d] = avgseries(readseries(fd, 3, 2, steps_per_second));
        means_std(j, 1) = mean(mean_d(length(mean_d)-steps_counted+1:length(mean_d)));
        means_std(j, 2) = mean(std_d(length(std_d)-steps_counted+1:length(std_d)));
    end
    
end

function test_cartpole()
    steps_counted = 10;
    printing = 0;
    folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
    addpath("~/Dropbox/phd_grl_results/matlab");

    type = ["good", "mid", "bad"];
    load = ["", "_load"];
    n = length(type);

    % % 
    tbl_meanstd_all = zeros(12, 2*n*length(load));

    env = "cart_pole"; env_abr = "cp";

    if (contains(env,"cart"))
        steps_per_second = 20;
    elseif (contains(env,"pendulum"))
        steps_per_second = 33;
    else
        disp("NONE NONE");
    end

    i=1;
    for j = 1:length(type)
        for k = 1:length(load)
            runs_generic = [type(j) + load(k) + "_*_none_none_1.0_density_a1.0_*txt",...
                            type(j) + load(k) + "_*_none_none_1.0_data_center_a1.0_*txt",...
                            type(j) + load(k) + "_*_none_none_1.0_mean_a1.0_*txt",...
                            type(j) + load(k) + "_*_none_none_1.0_random_a1_*txt",...
                            type(j) + load(k) + "_*_none_density_0.5_density_a0.01_*txt",...
                            type(j) + load(k) + "_*_none_density_0.5_data_center_a0.01_*txt",...
                            type(j) + load(k) + "_*_none_density_1.0_best_a0.01_*txt",...
                            type(j) + load(k) + "_*_density_euclidian_distance_0.01_best_a0.01_*txt",...
                            type(j) + load(k) + "_*_none_data_center_linear_order_1.0_best_a0.01_*txt",...
                            type(j) + load(k) + "_*_mean_euclidian_distance_0.5_density_a0.01_*txt",...
                            type(j) + load(k) + "_*_mean_euclidian_distance_0.5_data_center_a0.01_*txt",...
                            type(j) + load(k) + "_*_mean_euclidian_distance_0.1_best_a0.01_*txt"];
            [tbl_meanstd_all(:, 2*n*(k-1) + ((2*j)-1) : 2*n*(k-1) + (2*j))] = test_take_mean_mpol(folder, env, env_abr, load(k), runs_generic, printing, steps_per_second, steps_counted);
        end
    end

    type = "bad";
    runs_specific_bad = [         type + "_*_data_center_euclidian_distance_0.5_data_center_a0.01_*.txt",...
                                  type + "_*_data_center_euclidian_distance_0.5_data_center_a0.02_*.txt"];
    tbl_meanstd_specific_bad = test_take_mean_mpol(folder, env, env_abr, "", runs_specific_bad, printing, steps_per_second, steps_counted);

    % print_tbl_good_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good);
    % print_tbl_good_std_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, stdpd_good, bpd, bstdpd);
    % print_tbl_all_std_latex(strcat("Table of performance...steps_counted=", num2str(steps_counted)), pd_good, stdpd_good, pd_mid, stdpd_mid, pd_bad, stdpd_bad);

    disp(tbl_meanstd_all);
    disp(tbl_meanstd_specific_bad);
end

function test_printL_1env_tbl_all_std(caption, tbl)
    sz_base = 4;
    strategies = ["DC", "D", "M", "RND", "DC_MA_B", "DC_MA_25_DC", "DC_MA_50_DC",...
                  "DC_MA_75_DC", "DC_MA_50_D", "D_MA_50_D", "D_MA_50_DC", "D_MA_B",...
                  "DC_ED_MA_25_DC", "DC_EC_MA_50_DC", "DC_ED_MA_75_DC", "DC_ED_MA_B",...
                  "D_ED_MA_B", "DC_MA_B", "M_ED_MA_B", "M_ED_MA_25_D", "M_ED_MA_50_D",...
                  "M_ED_MA_75_D", "M_ED_MA_50_DC", "DC_MA_50_D"];
    strategies = ["DC", "D", "M", "RND", "DC\_MA\_B", "DC\_MA\_25\_DC", "DC\_MA\_50\_DC",...
                  "DC\_MA\_75\_DC", "DC\_MA\_50\_D", "D\_MA\_50\_D", "D\_MA\_50\_DC", "D\_MA\_B",...
                  "DC\_ED\_MA\_25\_DC", "DC\_EC\_MA\_50\_DC", "DC\_ED\_MA\_75\_DC", "DC\_ED\_MA\_B",...
                  "D\_ED\_MA\_B", "DC\_MA\_B", "M\_ED\_MA\_B", "M\_ED\_MA\_25\_D", "M\_ED\_MA\_50\_D",...
                  "M\_ED\_MA\_75\_D", "M\_ED\_MA\_50\_DC", "DC\_MA\_50\_D"];
%     fprintf("    \\multicolumn{1}{|l|}{\\multirow{4}{*}{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{D} & ");
%     fprinttex(pd(1,1:2), stdpd(1,1:2), up_pd, down_pd); fprintf(" & ");
%     fprinttex(cp(1,1:2), stdcp(1,1:2), up_cp, down_cp); fprintf(" & ");
%     fprinttex(cdp(1,1:2), stdcdp(1,1:2), up_cdp, down_cdp)
%     fprintf(" \\\\ \\cline{2-8} \n");
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC} & ");
%     fprinttex(pd(2,1:2), stdpd(2,1:2), up_pd, down_pd); fprintf(" & ");
%     fprinttex(cp(2,1:2), stdcp(2,1:2), up_cp, down_cp); fprintf(" & ");
%     fprinttex(cdp(2,1:2), stdcdp(2,1:2), up_cdp, down_cdp)
%     fprintf(" \\\\ \\cline{2-8} \n");    
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
        for i=1:2:size(tbl,2)
            max_base = max(tbl(1:sz_base, 3));
            ind_max_base = tbl(1:sz_base, 3) == max_base;
            max_basestd = max_base + tbl(ind_max_base, 2);
            fprintf(" & ");
            if ((tbl(j, i)+tbl(j, i+1)) >= max_basestd)
                fprintf("\\textbf{%.0f},\\textbf{%.0f}", tbl(j, i:i+1));
            else
                fprintf("%.0f,%.0f", tbl(j, i:i+1));
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
        for i=1:2:size(tbl,2)
            max_base = max(tbl(1:sz_base, 3));
            ind_max_base = tbl(1:sz_base, 3) == max_base;
            max_basestd = max_base - tbl(ind_max_base, 2);
            fprintf(" & ");
            if ((tbl(j, i)-tbl(j, i+1)) >= max_basestd)
                fprintf("\\textbf{%.0f},\\textbf{%.0f}", tbl(j, i:i+1));
            else
                fprintf("%.0f,%.0f", tbl(j, i:i+1));
            end
        end
        if (j == size(tbl, 1))
            fprintf(" \\\\ \\hline \n");
        else
            fprintf(" \\\\ \\cline{2-8} \n");
        end
    end
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC}");
%     test_fprinttex(tbl);
%     fprintf("\\\\ \\cline{2-11} \n");
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC}");
%     test_fprinttex(tbl);
%     fprintf("\\\\ \\cline{2-11} \n");
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC}");
%     test_fprinttex(tbl);
%     fprintf("\\\\ \\cline{2-11} \n");
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{RND} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\hline\n",...
% 		pd_good(4,2), stdpd_good(4,2), pd_mid(4,2), stdpd_mid(4,2), pd_bad(4,2), stdpd_bad(4,2), cp_good(4,2), stdcp_good(4,2), cp_mid(4,2), stdcp_mid(4,2), cp_bad(4,2), stdcp_bad(4,2), cdp_good(4,2), stdcdp_good(4,2), cdp_mid(4,2), stdcdp_mid(4,2), cdp_bad(4,2), stdcdp_bad(4,2));
%     fprintf("    \\multicolumn{1}{|l|}{\\multirow{8}{*}{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & \\footnotesize{D\\_MA\\_50\\_D}"+...
% 		" & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-11} \n",...
    fprintf("  \\end{tabular}\n");
    fprintf("\\end{table*}\n");
end

function test_fprinttex(tbl)
end

