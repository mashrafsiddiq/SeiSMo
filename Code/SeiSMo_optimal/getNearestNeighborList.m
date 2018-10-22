function nearestNeighborList = getNearestNeighborList(timeSeries, seedPosition, windowSize, isUseMASS, existingChains, maxChainLen)

    maxOverlapRelaxed = round((1 / 2) * windowSize);
    nearestNeighborList = [];
    isSinkFound = 0;
    
    currentNeighbor = seedPosition;
    nearestNeighborList = [nearestNeighborList currentNeighbor];
    currentDistance = -1;
    currChainLen = 1;
    while isSinkFound == 0
        [nearestNeighbor, currentDistance] = getNearestNeighbor(timeSeries, currentNeighbor, windowSize, isUseMASS, currentDistance);
        
        pathVisited = 0;
        if ~isempty(existingChains)
            for iPos = 1 : length(existingChains)
                iChain = existingChains(iPos).chain;
                for jPos = 1 : length(iChain)
                    if isDuplicate(nearestNeighbor, iChain(jPos), maxOverlapRelaxed) == 1
                        nearestNeighborList = [nearestNeighborList iChain(jPos : length(iChain))];
                        pathVisited = 1;
                        break;
                    end
                end
                if pathVisited == 1
                    break;
                end
            end
        end
        
        if pathVisited == 1
            break;
        end
        
        nearestNeighborListLen = length(nearestNeighborList);
        if nearestNeighborListLen > 1
            if isDuplicate(nearestNeighborList(nearestNeighborListLen - 1), nearestNeighbor, maxOverlapRelaxed) == 1
                isSinkFound = 1;
                break;
            end
        end
        nearestNeighborList = [nearestNeighborList, nearestNeighbor];
        currentNeighbor = nearestNeighbor;
        
        currChainLen = currChainLen + 1;
        if currChainLen >= maxChainLen
            break;
        end
    end
end