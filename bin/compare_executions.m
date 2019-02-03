function compare_executions(n, folder, nstd, title_fig, varargin)
    for i = 1:(nargin -4)
        name = varargin{i};
        file = folder + name;
        if i == 1
            array = [strrep(name,'_','.'), file];
        else
            array = [array; strrep(name,'_','.'), file];
        end
    end   

    figure('units','normalized','outerposition',[0 0 1 1]);
    leg = [];
    color = ['r', 'm', 'b', 'y', 'k', 'g', 'c'];
    num_alg = length(array);
    h = zeros(1, num_alg);
    for j=1:length(array)
        [mean_d, std_d] = load_mean(array(j,2), n);
        errstd_d = std_d/sqrt(n);
        maximum = max(mean_d);
        x = 1:length(mean_d);
        n_color = color(rem(j, length(color)));
        h(j) = plot(x, mean_d, 'Color', n_color, 'LineWidth', 1.3, 'LineStyle','-', 'DisplayName', strcat(array(j,1), ':... ', num2str(maximum)));
        leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
        hold on;
        plot(x, [mean_d - nstd*std_d; mean_d + nstd*std_d], 'Color', n_color, 'LineWidth', 0.3, 'LineStyle','-.');
        leg = [leg, ['-', num2str(nstd), '*std']];
        leg = [leg, [num2str(nstd), '*std']];
        hold on;
        plot(x, [mean_d - errstd_d; mean_d + errstd_d], 'Color', n_color, 'LineWidth', 0.5, 'LineStyle',':', 'HandleVisibility','off');
        leg = [leg, ['-', 'err_std']];
        leg = [leg, ['err_std']];
        hold on;
    end
    
    grid;
    title(title_fig);
    xlabel('step');
    ylabel('reward');
    legend(h,'Location','SouthEast');
end
