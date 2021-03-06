clc;
clear all;
close all;

n = 10;
folder = "~/Dropbox/phd_grl_results/phd_grl_mpol_results/walker_tuning_results/";
addpath("~/Dropbox/phd_grl_results/matlab");
steps_per_second = 5;
% %%
% % array_runs = [
% %     "compass_walker_walker_exemp_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.01_*txt",...
% %     "compass_walker_walker_exemp_replay_steps128_batch_size128_interval10000_gamma0.98_reward_scale0.1_*txt",...
% %     "compass_walker_walker_exemp_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.01_*txt",...
% %     "compass_walker_walker_exemp_replay_steps128_batch_size128_interval10000_gamma0.99_reward_scale0.1_*txt",...
% %     "compass_walker_walker_exemp_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.01_*txt",...
% %     "compass_walker_walker_exemp_replay_steps128_batch_size128_interval4000_gamma0.98_reward_scale0.1_*txt",...
% %     "compass_walker_walker_exemp_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.01_*txt",...
% %     "compass_walker_walker_exemp_replay_steps128_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt"];
% % title_fig = "FINDING BEST SINGLE WALKER";
% % 
% % ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% % array_runs = ["compass_walker_walker_exemp_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps128_batch_size256_interval10000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps128_batch_size256_interval10000_gamma0.99_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps128_batch_size256_interval4000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps128_batch_size256_interval4000_gamma0.99_reward_scale0.1_*txt"
% % ];
% % title_fig = "FINDING BEST SINGLE WALKER";
% % 
% % ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% array_runs = [
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
% ];
% title_fig = "FINDING BEST SINGLE WALKER";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% % array_runs = [
% % "compass_walker_walker_exemp_replay_steps256_batch_size128_interval10000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size128_interval10000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size128_interval10000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size128_interval10000_gamma0.99_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size128_interval4000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size128_interval4000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt",...
% % ];
% % title_fig = "FINDING BEST SINGLE WALKER";
% % 
% % ploting_executions(folder, title_fig, steps_per_second, array_runs);
% % 
% %%
% % array_runs = [
% % "compass_walker_walker_exemp_replay_steps256_batch_size256_interval10000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size256_interval10000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size256_interval10000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size256_interval10000_gamma0.99_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size256_interval4000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size256_interval4000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size256_interval4000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps256_batch_size256_interval4000_gamma0.99_reward_scale0.1_*txt",...
% % ];
% % title_fig = "FINDING BEST SINGLE WALKER";
% % 
% % ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% array_runs = [
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
% ];
% title_fig = "FINDING BEST SINGLE WALKER";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% array_runs = [
% "compass_walker_walker_exemp_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt",...
% ];
% title_fig = "FINDING BEST SINGLE WALKER";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% % array_runs = [
% % "compass_walker_walker_exemp_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size256_interval10000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size256_interval10000_gamma0.99_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size256_interval4000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size256_interval4000_gamma0.99_reward_scale0.1_*txt",...
% % ];
% % title_fig = "FINDING BEST SINGLE WALKER";
% % 
% % ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% % array_runs = [
% % "compass_walker_walker_exemp_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps32_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
% % ];
% % title_fig = "FINDING BEST SINGLE WALKER";
% % 
% % ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% % array_runs = [
% % "compass_walker_walker_exemp_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size128_interval10000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size128_interval10000_gamma0.99_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size128_interval4000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt",...
% % ];
% % title_fig = "FINDING BEST SINGLE WALKER";
% % 
% % ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% % array_runs = [
% % "compass_walker_walker_exemp_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size256_interval10000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size256_interval10000_gamma0.99_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size256_interval4000_gamma0.98_reward_scale0.1_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.01_*txt",...
% % "compass_walker_walker_exemp_replay_steps64_batch_size256_interval4000_gamma0.99_reward_scale0.1_*txt",...
% % ];
% % title_fig = "FINDING BEST SINGLE WALKER";
% % 
% % ploting_executions(folder, title_fig, steps_per_second, array_runs);
% 
% %%
% array_runs = [
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
% ];
% title_fig = "FINDING BEST SINGLE WALKER";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
% array_runs = [
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps128_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
% ];
% title_fig = "FINDING BEST SINGLE WALKER";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);

array_runs = [
"compass_walker_walker_exemp_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps128_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
"compass_walker_walker_exemp_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps128_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
% array_runs = [
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps256_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
% ];
% title_fig = "FINDING BEST SINGLE WALKER";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);

array_runs = [
"compass_walker_walker_exemp_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps256_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
"compass_walker_walker_exemp_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps256_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_exemp_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps32_batch_size128_interval10000_gamma0.98_reward_scale0.1_*txt",...
"compass_walker_walker_exemp_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps32_batch_size128_interval10000_gamma0.99_reward_scale0.1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

array_runs = [
"compass_walker_walker_exemp_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps32_batch_size128_interval4000_gamma0.98_reward_scale0.1_*txt",...
"compass_walker_walker_exemp_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps32_batch_size128_interval4000_gamma0.99_reward_scale0.1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_exemp_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps64_batch_size64_interval10000_gamma0.98_reward_scale0.1_*txt",...
"compass_walker_walker_exemp_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_exemp_replay_steps64_batch_size64_interval10000_gamma0.99_reward_scale0.1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

% array_runs = [
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval4000_gamma0.98_reward_scale0.1_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.01_*txt",...
% "compass_walker_walker_exemp_replay_steps64_batch_size64_interval4000_gamma0.99_reward_scale0.1_*txt",...
% ];
% title_fig = "FINDING BEST SINGLE WALKER";
% 
% ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.99_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.99_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval40_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval40_gamma0.99_reward_scale0.1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval20_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval30_gamma0.99_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval40_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval50_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval60_gamma0.99_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps256_batch_size64_interval10_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps256_batch_size64_interval20_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps256_batch_size64_interval30_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps256_batch_size64_interval40_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps256_batch_size64_interval50_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps256_batch_size64_interval60_gamma0.99_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval4_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval8_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval20_gamma0.99_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval30_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval40_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval50_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval60_gamma0.99_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.75_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval70_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval80_gamma0.99_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval90_gamma0.99_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.45_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.45_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.45_reward_scale1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.55_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.55_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.55_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.65_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.65_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.65_reward_scale1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.85_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.85_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.85_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.9_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.9_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval100_gamma0.9_reward_scale1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.45_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.45_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.45_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.55_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.55_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.55_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.65_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.65_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.65_reward_scale1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.85_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.85_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.85_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.9_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.9_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.9_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.45_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.45_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.45_reward_scale1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.55_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.55_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.55_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.65_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.65_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.65_reward_scale1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.85_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.85_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.85_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.9_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.9_reward_scale0.1_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.9_reward_scale1_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.65_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.65_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.85_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.85_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.65_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval1_gamma0.85_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.65_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.75_reward_scale0.01_*txt",...
"compass_walker_walker_replay_steps128_batch_size64_interval10_gamma0.85_reward_scale0.01_*txt",...
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);

%%
array_runs = [
];
title_fig = "FINDING BEST SINGLE WALKER";

ploting_executions(folder, title_fig, steps_per_second, array_runs);
