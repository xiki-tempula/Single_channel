function PlotClusterResult(X, idx, means, STD)
X = X';
X = X .* (STD * ones(1,size(X,2))) + means * ones(1,size(X,2));

Time = zeros(1, size(X,2) *2);
Time(1:2:end) = X(1,:);
Time(2:2:end) = X(2,:);

temp_amp = ones(1,length(Time));
temp_amp(2:2:end) = 0;
Amp = ones(1,2*length(Time));
Amp(1:2:end) = temp_amp;
Amp(2:2:end) = temp_amp;

temp_time = exp(Time);
temp_time = cumsum(temp_time);
time = ones(1,2*length(Time));
time(1:2:end) = temp_time;
time(2:2:end) = temp_time;
time = time(1:end-1);
time = [0 time];
time = time + (X(3,1) - temp_time(1));


figure
plot(time, Amp)
hold on
for result_number = 1:size(idx,1)
    tempidx = idx(result_number,:);
    cmp = colormap(parula(length(unique(tempidx))));
    if length(unique(tempidx)) > 1
        for i = 1:length(unique(tempidx))
            index = find(tempidx == i);
            x = [time(min(index)*4-3), time(max(index)*4)];
            plot(x, (1.1 + (result_number-1)*0.1)*ones(1,2), 'Color', cmp(i,:), 'LineWidth', 5)
        end
    end
end
hold off

