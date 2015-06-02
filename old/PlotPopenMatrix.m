function PopenMatrixGraph = PlotPopenMatrix(dwell, startInterval, endInterval, jump)
PopenMtrix = genPopenMatrix(dwell, startInterval, endInterval, jump);
xscale = linspace(0, sum(dwell), floor(sum(dwell)/jump));
yscale = linspace(startInterval, endInterval, floor((endInterval - startInterval) / jump) + 1);

PopenMatrixGraph = figure;
imagesc(xscale, yscale, PopenMtrix);
colormap(PopenMatrixGraph, 'hot')
end