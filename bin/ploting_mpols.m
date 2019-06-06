function ploting_mpols(n, folder, subfolder, preffix, steps_per_second, type, title_fig, varargin)
    array_runs = [];
    for(i=1:(nargin-7))
      array_runs = [array_runs, subfolder + preffix + type + varargin{i} + "*.txt"];
    end
    
    ploting_executions(folder, title_fig, steps_per_second, array_runs);
end
