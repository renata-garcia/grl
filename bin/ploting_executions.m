function ploting_executions(folder, title_fig, steps_per_second, array_runs)
    size_windows = [0 0 1 1];
    leg = [];

    fig = figure('units','normalized','outerposition',size_windows);
    subplot(2,2,1);
    color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
    h = zeros(1, length(array_runs));
    for j=1:size(array_runs,2)
        fd = folder + array_runs(j);
%         disp(fd);
        data = readseries(fd, 3, 2, steps_per_second);
        [t, mean_d, ~, std_d] = avgseries(data);
        maximum = max(mean_d);
        n_color = color(1 + rem(j, length(color)));
        h(j) = errorbaralpha(t, mean_d, icdf('norm', 0.975, 0, 1)*std_d, 'color', n_color, 'linestyle', '--');
        newStrLeg = strrep(array_runs(j),'_','\_');
        leg = [leg, strcat(newStrLeg, ':... ', num2str(maximum))];
        hold on;
    end
    xlim([0 3000])
    grid;
%     title([title_fig, ' (int val 95)']);
    xlabel('seconds');
    ylabel('reward');
%     legend(h, leg,'Location','SouthEast');
     print(fig, strcat("figs/plots_", title_fig, " (int val 95)",".png"),'-dpng');
%     close;
end



