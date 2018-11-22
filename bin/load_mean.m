function mean = load_mean(file, n)
    sum = load(file + "-0.txt");
    for i=1:(n-1)
        sum = sum + load(file + "-" + i + ".txt");
    end
    mean = sum(:,3)/n;
end