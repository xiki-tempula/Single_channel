function plot_Clustering(data)

idx_size = size(data.idx, 1);
figure(2);
clf;

for i = 1:idx_size
    idx = data.idx(i,:);
    cmp = colormap(parula(i));
    opentime = data.opentime;
    closetime = data.closetime;
    eventtime = data.eventtime;
    
    subplot(idx_size/2, 2, i)
    [hAx,hLine1,hLine2] = plotyy(eventtime, opentime,...
            eventtime, closetime, 'semilogy', 'semilogy');
    hLine1.LineStyle = 'none';
    hLine2.LineStyle = 'none';
    xlabel('Event time (ms)')

    ylabel(hAx(1),'Open time (log scale)') % left y-axis
    ylabel(hAx(2),'Close time (log scale)')
    
    xlim(hAx(1),[min(eventtime), max(eventtime)])
    xlim(hAx(2),[min(eventtime), max(eventtime)])
    for j = 1:length(unique(idx))
        index = find(idx == j);
        
        hold(hAx(1), 'on');
        plot(hAx(1), eventtime(index), opentime(index),...
            'LineStyle', 'none', 'Marker', 'o',...
            'MarkerEdgeColor', cmp(j,:))
       
        hold(hAx(1), 'off');
        
        hold(hAx(2), 'on');
        plot(hAx(2), eventtime(index), closetime(index),...
            'LineStyle', 'none', 'Marker', 'x',...
            'MarkerEdgeColor', cmp(j,:))
        
        hold(hAx(2), 'off');
    end

end




