function compare_executions(n, folder, nstd, lim_x, title_fig, varargin)
    size_windows = [0 0 1.0 1.0];
    for i = 1:(nargin -5)
        name = varargin{i};
        file = folder + name;
        if i == 1
            array = [strrep(name,'_','.'), file];
        else
            array = [array; strrep(name,'_','.'), file];
        end
    end
% %   ------------------------------------------------------
%     
%     figure('units','normalized','outerposition',size_windows);
%     leg = [];
%     color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
%     num_alg = length(array);
%     h = zeros(1, num_alg);
%     for j=1:size(array,1)
%         [mean_d, std_d] = load_mean(array(j,2), n, lim_x);
%         errstd_d = std_d/sqrt(n);
%         maximum = max(mean_d);
%         x = 1:length(mean_d);
%         n_color = color(1 + rem(j, length(color)));
%         h(j) = errorbaralpha(mean_d, std_d, 'color', n_color, 'linestyle', '--');
%         leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
%         hold on;
%     end
%     
%     grid;
%     title(title_fig);
%     xlabel('step');
%     ylabel('reward');
%     legend(h, leg,'Location','SouthEast');

%   ------------------------------------------------------
%   PLOT INTERVALO
    
    figure('units','normalized','outerposition',size_windows);
    leg = [];
    color = ['y', 'm', 'b', 'r', 'k', 'g', 'c'];
    num_alg = length(array);
    h = zeros(1, num_alg);
    for j=1:size(array,1)
        [mean_d, std_d] = load_mean(array(j,2), n, lim_x);
        errstd_d = std_d/sqrt(n);
        maximum = max(mean_d);
        x = 1:length(mean_d);
        n_color = color(1 + rem(j, length(color)));
        h(j) = errorbaralpha(mean_d, (n + 1.96*(std_d/sqrt(n))), 'color', n_color, 'linestyle', '--');
        leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
        hold on;
    end
    
    grid;
    title([title_fig, ' (int val 95)']);
    xlabel('step');
    ylabel('reward');
    legend(h, leg,'Location','SouthEast');

end