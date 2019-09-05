function [mean_d, std_d] = load_mean(file, n, lim_x)
    at = load(file + "-0.txt");
    s = size(at);
    s(1) = lim_x;
    data = zeros(n,s(1));
    
    sum = load(file + "-0.txt");
    %display(n);
    for i=1:n
        tmp = load(file + "-" + (i-1) + ".txt");
        %display(file + "-" + (i-1) + ".txt");
        %display(size(tmp));
        data(i,:) = tmp(1:lim_x,3);
    end
    mean_d = mean(data);
    std_d = std(data);
end
