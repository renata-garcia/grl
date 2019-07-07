https://www.mathworks.com/matlabcentral/answers/85219-subplot-of-already-saved-figures
https://www.mathworks.com/matlabcentral/answers/101806-how-can-i-insert-my-matlab-figure-fig-files-into-multiple-subplots


% clc;
% clear all;
% close all;
% 
% n = 10;
% folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/";
% addpath("~/Dropbox/phd_grl_results/matlab");
% 
% nenv = 3;
% old_name = 1;
% 
% size_windows = [0 0 1 1];
% figure('units','normalized','outerposition',size_windows);
% title_fig = "FINDING BEST SINGLE LEOSIM";
% 
% type = "good";
% color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
% h = [1, 9];
% leg = [];
% array_runs = [];
% hold all;
% hold on;
% for k=1:nenv
%     switch nenv
%         case 1
%             env = "pendulum";
%             env_abr = "pd";
%             env_title = "PENDULUM";
%             steps_per_second = 33;
%             subfolder1 = env + "_mpols_yamls_results/";
%             subfolder2 = env + "_mpols_load_yamls_results/";
%             preffix1 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type;
%             preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
%             array_runs = [subfolder1 + preffix1 + "_*_mean_euclidian_distance_0.1_best_a0.01_" + "*.txt",...
%                           subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.1_best_a0.01_" + "*.txt"];
%             num_alg = length(array_runs);
% %             h = zeros(1, num_alg);
%             h(k) = subplot(3,3,1);
%         case 2
%             env = "pendulum";
%             env_abr = "pd";
%             env_title = "PENDULUM";
%             steps_per_second = 33;
%             subfolder1 = env + "_mpols_yamls_results/";
%             subfolder2 = env + "_mpols_load_yamls_results/";
%             preffix1 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type;
%             preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
%             array_runs = [subfolder1 + preffix1 + "_*_mean_euclidian_distance_0.5_density_a0.01_" + "*.txt",...
%                           subfolder2 + preffix2 + "_*_mean_euclidian_distance_0.5_density_a0.01_" + "*.txt"];
%             num_alg = length(array_runs);
% %             h = zeros(1, num_alg);
%             h(k) = subplot(3,3,2);
%         case 3
%             env = "pendulum";
%             env_abr = "pd";
%             env_title = "PENDULUM";
%             steps_per_second = 33;
%             subfolder1 = env + "_mpols_yamls_results/";
%             subfolder2 = env + "_mpols_load_yamls_results/";
%             preffix1 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type;
%             preffix2 = env + "_" + env_abr + "_tau_mpol_replay_ddpg_tensorflow_sincos_16" + type + "_load";
%             array_runs = [subfolder1 + preffix1 + "_*_none_data_center_linear_order_1.0_best_a0.01_" + "*.txt",...
%                           subfolder2 + preffix2 + "_*_none_data_center_linear_order_1.0_best_a0.01_" + "*.txt"];
%             num_alg = length(array_runs);
% %             h = zeros(1, num_alg);
%             h(k) = subplot(3,3,3);
%     end
% %     hold all;
%     hold on;
%     for j=1:size(array_runs,2)
%         fd = folder + array_runs(j);
%         disp(fd);
%         data = readseries(fd, 3, 2, steps_per_second);
%         [t, mean_d, ~, std_d] = avgseries(data);
%         maximum = max(mean_d);
%         n_color = color(1 + rem(j, length(color)));
%         errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
%         hold on;
%         newStrLeg = strrep(array_runs(j),'_','\_');
%         leg = [leg, strcat(newStrLeg, ':... ', num2str(maximum))];
%     end
% end
% % grid;
% title([title_fig, ' (int val 95)']);
% % xlabel('seconds');
% % ylabel('reward');
% % legend(h, leg,'Location','SouthEast');
