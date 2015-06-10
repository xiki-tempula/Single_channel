function plot_original_data(cluster)
% Plot the original signal

% Calculate the X (time) axis
Time = zeros(1, length(cluster.opentime) * 2);
Time(1:2:end) = cluster.opentime;
Time(2:2:end) = cluster.closetime;
Time = cumsum(Time);
plot_time = ones(1,2*length(Time));
plot_time(1:2:end) = Time;
plot_time(2:2:end) = Time;
plot_time = plot_time(1:end-1);
plot_time = [0 plot_time];
plot_time = plot_time + (cluster.eventtime(1) - Time(1));

% Calculate the amplitude
plot_amp = ones(1,length(plot_time));
plot_amp(1:2:end) = cluster.amplitude;
plot_amp(2:2:end) = cluster.amplitude;

figure(1)
clf;
plot(plot_time, plot_amp, 'k')
xlim([min(plot_time), max(plot_time)])