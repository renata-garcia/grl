function [mean_d, std_d] = load_mean(file, n)
    at = load(file + "-0.txt");
    s = size(at);
    data = zeros(n,s(1));
    
    sum = load(file + "-0.txt");
    for i=1:n
        tmp = load(file + "-" + (i-1) + ".txt");
        data(i,:) = tmp(:,3);
    end
    mean_d = mean(data);
    std_d = std(data);
end
