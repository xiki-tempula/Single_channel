function plot_Kmeans(X, idx)


if length(unique(idx)) > 1
    hFig = figure;
    cmp = colormap(parula(length(unique(idx))));
    % Create empty figure with two axis and correct x & y range, then make
    % them invisible.
    [hAx,hLine1,hLine2] = plotyy(X(3,:), X(1,:),...
            X(3,:), X(2,:));
    hLine1.LineStyle = 'none';
    hLine2.LineStyle = 'none';
    
    title('Open/Close time distrubition')
    xlabel('Event time (ms)')

    ylabel(hAx(1),'Open time (log scale)') % left y-axis
    ylabel(hAx(2),'Close time (log scale)')
    
    for i = 1:length(unique(idx))
        index = find(idx == i);
        
        hold(hAx(1), 'on');
        plot(hAx(1), X(3,index), X(1,index),...
            'LineStyle', 'none', 'Marker', 'o',...
            'MarkerEdgeColor', cmp(i,:))
        hold(hAx(1), 'off');
        
        hold(hAx(2), 'on');
        plot(hAx(2), X(3,index), X(2,index),...
            'LineStyle', 'none', 'Marker', 'x',...
            'MarkerEdgeColor', cmp(i,:))
        hold(hAx(2), 'off');
    end
    pause
    close(hFig)
end




