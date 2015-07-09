function plotopenclose(cluster)
figure
[hAx,hLine1,hLine2] = plotyy(cluster.eventtime, cluster.opentime,...
    cluster.eventtime, cluster.closetime,...
    'semilogy', 'semilogy');

hLine1.LineStyle = 'none';
hLine2.LineStyle = 'none';

hLine1.Marker = 'o';
hLine2.Marker = 'x';

title('Open/Close time distrubition')
xlabel('Event time (ms)')

ylabel(hAx(1),'Open time (log scale)') % left y-axis
ylabel(hAx(2),'Close time (log scale)')


