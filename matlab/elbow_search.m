function idxOfBestPoint = elbow_search(Cost)

nPoints = length(Cost);
allCoord = [1:nPoints;Cost]'; 

firstPoint = allCoord(1,:);
lineVec = allCoord(end,:) - firstPoint;

lineVecN = lineVec / sqrt(sum(lineVec.^2));

vecFromFirst = bsxfun(@minus, allCoord, firstPoint);

scalarProduct = dot(vecFromFirst, repmat(lineVecN,nPoints,1), 2);
vecFromFirstParallel = scalarProduct * lineVecN;
vecToLine = vecFromFirst - vecFromFirstParallel;

distToLine = sqrt(sum(vecToLine.^2,2));
[maxDist,idxOfBestPoint] = max(distToLine);
