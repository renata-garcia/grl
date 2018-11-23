clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";

%%
%renatargo@REPCmint ~/projects/grl/build $ mv mpol_dpg_13_density_based_mm_b2_rd01_data* /home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/
%renatargo@REPCmint ~/projects/grl/build $ mv mpol_dpg_20_data_center_mm_b2_rd97_data* /home/renatargo/Dropbox/phd_grl_results/phd_grl_mpol_results/


%%
name = "pendulum_ac_tc";
file = folder + name;
array = [strrep(name,'_','.'), file];

name = "mpol_dpg_13_data_center_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_random_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_greedy_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_density_based_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_mean_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))


%%
name = "pendulum_ac_tc";
file = folder + name;
array = [strrep(name,'_','.'), file];

name = "pendulum_dpg.dat";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_data_center_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_random_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))



%%

name = "mpol_dpg_13_density_based_mm_b2_rd10_data";
file = folder + name;
array = [strrep(name,'_','.'), file];

name = "pendulum_ac_tc";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "pendulum_dpg.dat";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_data_center_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_random_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))


%%
name = "mpol_dpg_13_data_center_mm_b2_rd90_data";
file = folder + name;
array = [strrep(name,'_','.'), file];

name = "mpol_dpg_13_data_center_mm_b2_rd75_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_data_center_mm_b2_rd01_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_data_center_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_data_center_mm_b2_rd98_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))

%%
name = "mpol_dpg_13_density_based_mm_b2_rd10_data";
file = folder + name;
array = [strrep(name,'_','.'), file];

name = "mpol_dpg_13_density_based_mm_b2_rd01_data";
file = folder + name;
array = [strrep(name,'_','.'), file];

name = "mpol_dpg_13_density_based_mm_b2_rd75_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_13_density_based_mm_b2_rd90_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))

%%
name = "pendulum_ac_tc";
file = folder + name;
array = [ strrep(name,'_','.'), file];

name = "pendulum_dpg.dat";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_rd01_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_rd001_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))

%%
name = "pendulum_ac_tc";
file = folder + name;
array = [ strrep(name,'_','.'), file];

name = "pendulum_dpg.dat";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_mm_b2_rd01_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_mm_b2_rd75_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_mm_b2_rd90_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))

%%
name = "pendulum_ac_tc";
file = folder + name;
array = [ strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_data";
file = folder + name;
array = [array;strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_5_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_mm_b2_rd01_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_mm_b2_rd75_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_mm_b2_rd90_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))

%%
name = "mpol_dpg_20_density_data";
file = folder + name;
array = [strrep(name,'_','.'), file];

name = "pendulum_ac_tc";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "pendulum_dpg.dat";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_5_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_mm_b2_rd90_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_mm_b2_rd01_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_mm_b2_rd75_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_mm_b2_rd90_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_rd001_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_density_based_rd01_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

name = "mpol_dpg_20_data_center_data";
file = folder + name;
array = [array; strrep(name,'_','.'), file];

figure;
leg = [];
for j=1:length(array)
    mean = load_mean(array(j,2), n);
    maximum = max(mean);
    x = 1:length(mean);
    h = plot(x, mean);
    leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
    hold on;
end

grid;
title('asd');
xlabel('n');
ylabel('y');
legend(leg,'Location','SouthEast');
%strcat('Location:... ',num2str(maximum))

