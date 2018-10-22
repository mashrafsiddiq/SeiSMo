function nearestNeighborList = getNearestNeighborList(timeSeries, seedPosition, windowSize, isUseMASS, maxChainLen)

    maxOverlapRelaxed = round((1 / 2) * windowSize);
    nearestNeighborList = [];
    isSinkFound = 0;
    
    currentNeighbor = seedPosition;
    nearestNeighborList = [nearestNeighborList currentNeighbor];
    currChainLen = 1;
    while isSinkFound == 0
        nearestNeighbor = getNearestNeighbor(timeSeries, currentNeighbor, windowSize, isUseMASS);
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