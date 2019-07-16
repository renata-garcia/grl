clc;
clear;
close all;

% % 
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
addpath("~/Dropbox/phd_grl_results/matlab");

steps_counted = 10;
printing = 0;

tbl_mean_all = zeros(12, 6*3);
tbl_std_all = zeros(12, 6*3);

for i=1:3
    if (i == 1)
    	env = "pendulum"; env_abr = "pd";
    elseif (i == 2)
        env = "cart_pole"; env_abr = "cp";
    elseif (i == 3)
%         env = "cart_double_pole"; env_abr = "cdp";
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
cp_good = tbl_mean_all(:, 7:8);
cdp_good = tbl_mean_all(: , 13:14);
perf_good = [pd_good,cp_good,cdp_good];

stdpd_good = tbl_std_all(:, 1:2);
stdcp_good = tbl_std_all(:, 7:8);
stdcdp_good = tbl_std_all(: , 13:14);
perf_stdgood = [stdpd_good,stdcp_good,stdcdp_good];

print_tbl_good_latex(pd_good, cp_good, cdp_good);
disp("");disp("");disp("");
print_tbl_good_std_latex(pd_good, cp_good, cdp_good, stdpd_good, stdcp_good, stdcdp_good);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

function print_tbl_good_latex(pd, cp, cdp)
	fprintf("%% Please add the following required packages to your document preamble:\n");
    fprintf("%% \\usepackage{multirow}\n");
    fprintf("  \\begin{table*}[]\n");
    fprintf("  \\centering\n");
    fprintf("  \\caption{Table of performance...}\n");
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
    fprintf("\\end{table*}]\n");
end

% backup
% function print_tbl_good_std_latex(pd, cp, cdp, stdpd, stdcp, stdcdp)
% 	fprintf("%% Please add the following required packages to your document preamble:\n");
%     fprintf("%% \\usepackage{multirow}\n");
%     fprintf("  \\begin{table*}[]\n");
%     fprintf("  \\centering\n");
%     fprintf("  \\caption{Table of performance...}\n");
%     fprintf("  \\label{tab_performance_base_new}\n");
%     fprintf("  \\begin{tabular}{l|c|c|c|c|c|c|c|}\n");
%     fprintf("    \\cline{2-8}\n");
%     fprintf("     & strategy & \\multicolumn{2}{c|}{pendulum} & \\multicolumn{2}{c|}{cart pole} & \\multicolumn{2}{c|}{cart double pole} \\\\ \\cline{3-8} \n");
%     fprintf("     &  & learned & learning & learned & learning & learned & learning \\\\ \\hline\n");
%     fprintf("    \\multicolumn{1}{|l|}{\\multirow{4}{*}{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{D} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(1,1), stdpd(1,1), pd(1,2), stdpd(1,2), cp(1,1), stdcp(1,1), cp(1,2), stdcp(1,2), cdp(1,1), stdcdp(1,1), cdp(1,2), stdcdp(1,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(2,1), stdpd(2,1), pd(2,2), stdpd(2,2), cp(2,1), stdcp(2,1), cp(2,2), stdcp(2,2), cdp(2,1), stdcdp(2,1), cdp(2,2), stdcdp(2,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(3,1), stdpd(3,1), pd(3,2), stdpd(3,2), cp(3,1), stdcp(3,1), cp(3,2), stdcp(3,2), cdp(3,1), stdcdp(3,1), cdp(3,2), stdcdp(3,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{RND} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\hline\n", pd(4,1), stdpd(4,1), pd(4,2), stdpd(4,2), cp(4,1), stdcp(4,1), cp(4,2), stdcp(4,2), cdp(4,1), stdcdp(4,1), cdp(4,2), stdcdp(4,2));
%     fprintf("    \\multicolumn{1}{|l|}{\\multirow{8}{*}{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & \\footnotesize{D\\_MA\\_50\\_D} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(5,1), stdpd(5,1), pd(5,2), stdpd(5,2), cp(5,1), stdcp(5,1), cp(5,2), stdcp(5,2), cdp(5,1), stdcdp(5,1), cdp(5,2), stdcdp(5,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_MA\\_50\\_DC} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(6,1), stdpd(6,1), pd(6,2), stdpd(6,2), cp(6,1), stdcp(6,1), cp(6,2), stdcp(6,2), cdp(6,1), stdcdp(6,1), cdp(6,2), stdcdp(6,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_MA\\_B} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(7,1), stdpd(7,1), pd(7,2), stdpd(7,2), cp(7,1), stdcp(7,1), cp(7,2), stdcp(7,2), cdp(7,1), stdcdp(7,1), cdp(7,2), stdcdp(7,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_ED\\_MA\\_B} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \n", pd(8,1), stdpd(8,1), pd(8,2), stdpd(8,2), cp(8,1), stdcp(8,1), cp(8,2), stdcp(8,2), cdp(8,1), stdcdp(8,1), cdp(8,2), stdcdp(8,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC\\_MA\\_B} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(9,1), stdpd(9,1), pd(9,2), stdpd(9,2), cp(9,1), stdcp(9,1), cp(9,2), stdcp(9,2), cdp(9,1), stdcdp(9,1), cdp(9,2), stdcdp(9,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_50\\_D} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(10,1), stdpd(10,1), pd(10,2), stdpd(10,2), cp(10,1), stdcp(10,1), cp(10,2), stdcp(10,2), cdp(10,1), stdcdp(10,1), cdp(10,2), stdcdp(10,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_50\\_DC} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\cline{2-8} \n", pd(11,1), stdpd(11,1), pd(11,2), stdpd(11,2), cp(11,1), stdcp(11,1), cp(11,2), stdcp(11,2), cdp(11,1), stdcdp(11,1), cdp(11,2), stdcdp(11,2));
%     fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_B} & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ & $%.0f \\pm %.0f$ \\\\ \\hline\n", pd(12,1), stdpd(12,1), pd(12,2), stdpd(12,2), cp(12,1), stdcp(12,1), cp(12,2), stdcp(12,2), cdp(12,1), stdcdp(12,1), cdp(12,2), stdcdp(12,2));
%     fprintf("  \\end{tabular}\n");
%     fprintf("\\end{table*}]\n");
% end

function print_tbl_good_std_latex(pd, cp, cdp, stdpd, stdcp, stdcdp)
	fprintf("%% Please add the following required packages to your document preamble:\n");
    fprintf("%% \\usepackage{multirow}\n");
    fprintf("  \\begin{table*}[]\n");
    fprintf("  \\centering\n");
    fprintf("  \\footnotesize\n");
    fprintf("  \\caption{Table of performance...}\n");
    fprintf("  \\label{tab_performance_base_new}\n");
    fprintf("  \\begin{tabular}{l|c|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{-1}|D{,}{\\pm}{4.4}|}\n");
    fprintf("    \\cline{2-8}\n");
    fprintf("     & strategy & \\multicolumn{2}{c|}{pendulum} & \\multicolumn{2}{c|}{cart pole} & \\multicolumn{2}{c|}{cart double pole} \\\\ \\cline{3-8} \n");
    fprintf("     &  & \\multicolumn{1}{|c|}{learned} & \\multicolumn{1}{|c|}{learning} & \\multicolumn{1}{|c|}{learned} & \\multicolumn{1}{|c|}{learning} & \\multicolumn{1}{|c|}{learned} & \\multicolumn{1}{|c|}{learning} \\\\ \\hline\n");
    fprintf("    \\multicolumn{1}{|l|}{\\multirow{4}{*}{\\STAB{\\rotatebox[origin=c]{90}{BASE}}}} & \\footnotesize{D} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(1,1), stdpd(1,1), pd(1,2), stdpd(1,2), cp(1,1), stdcp(1,1), cp(1,2), stdcp(1,2), cdp(1,1), stdcdp(1,1), cdp(1,2), stdcdp(1,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(2,1), stdpd(2,1), pd(2,2), stdpd(2,2), cp(2,1), stdcp(2,1), cp(2,2), stdcp(2,2), cdp(2,1), stdcdp(2,1), cdp(2,2), stdcdp(2,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(3,1), stdpd(3,1), pd(3,2), stdpd(3,2), cp(3,1), stdcp(3,1), cp(3,2), stdcp(3,2), cdp(3,1), stdcdp(3,1), cdp(3,2), stdcdp(3,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{RND} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\hline\n", pd(4,1), stdpd(4,1), pd(4,2), stdpd(4,2), cp(4,1), stdcp(4,1), cp(4,2), stdcp(4,2), cdp(4,1), stdcdp(4,1), cdp(4,2), stdcdp(4,2));
    fprintf("    \\multicolumn{1}{|l|}{\\multirow{8}{*}{\\STAB{\\rotatebox[origin=c]{90}{NEW}}}} & \\footnotesize{D\\_MA\\_50\\_D} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(5,1), stdpd(5,1), pd(5,2), stdpd(5,2), cp(5,1), stdcp(5,1), cp(5,2), stdcp(5,2), cdp(5,1), stdcdp(5,1), cdp(5,2), stdcdp(5,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_MA\\_50\\_DC} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(6,1), stdpd(6,1), pd(6,2), stdpd(6,2), cp(6,1), stdcp(6,1), cp(6,2), stdcp(6,2), cdp(6,1), stdcdp(6,1), cdp(6,2), stdcdp(6,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_MA\\_B} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(7,1), stdpd(7,1), pd(7,2), stdpd(7,2), cp(7,1), stdcp(7,1), cp(7,2), stdcp(7,2), cdp(7,1), stdcdp(7,1), cdp(7,2), stdcdp(7,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{D\\_ED\\_MA\\_B} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(8,1), stdpd(8,1), pd(8,2), stdpd(8,2), cp(8,1), stdcp(8,1), cp(8,2), stdcp(8,2), cdp(8,1), stdcdp(8,1), cdp(8,2), stdcdp(8,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{DC\\_MA\\_B} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(9,1), stdpd(9,1), pd(9,2), stdpd(9,2), cp(9,1), stdcp(9,1), cp(9,2), stdcp(9,2), cdp(9,1), stdcdp(9,1), cdp(9,2), stdcdp(9,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_50\\_D} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(10,1), stdpd(10,1), pd(10,2), stdpd(10,2), cp(10,1), stdcp(10,1), cp(10,2), stdcp(10,2), cdp(10,1), stdcdp(10,1), cdp(10,2), stdcdp(10,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_50\\_DC} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\cline{2-8} \n", pd(11,1), stdpd(11,1), pd(11,2), stdpd(11,2), cp(11,1), stdcp(11,1), cp(11,2), stdcp(11,2), cdp(11,1), stdcdp(11,1), cdp(11,2), stdcdp(11,2));
    fprintf("    \\multicolumn{1}{|l|}{} & \\footnotesize{M\\_ED\\_MA\\_B} & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f & %.0f,%.0f \\\\ \\hline\n", pd(12,1), stdpd(12,1), pd(12,2), stdpd(12,2), cp(12,1), stdcp(12,1), cp(12,2), stdcp(12,2), cdp(12,1), stdcdp(12,1), cdp(12,2), stdcdp(12,2));
    fprintf("  \\end{tabular}\n");
    fprintf("\\end{table*}]\n");
end