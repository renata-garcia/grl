function compare_executions(n, folder, title_fig, varargin)
    for i = 1:(nargin -3)
        name = varargin{i};
        file = folder + name;
        if i == 1
            array = [strrep(name,'_','.'), file];
        else
            array = [array; strrep(name,'_','.'), file];
        end
    end   

    figure('units','normalized','outerposition',[0 0 0.5 0.5]);
    leg = [];
    for j=1:length(array)
        mean = load_mean(array(j,2), n);
        maximum = max(mean);
        x = 1:length(mean);
        plot(x, mean);
        leg = [leg, strcat(array(j,1), ':... ', num2str(maximum))];
        hold on;
    end

    grid;
    title(title_fig);
    xlabel('step');
    ylabel('reward');
    legend(leg,'Location','SouthEast');
end