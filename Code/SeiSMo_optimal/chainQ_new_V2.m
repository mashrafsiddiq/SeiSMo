function filteredDetectedEvents = chainQ_new_V2(timeSeries, seedPositions, windowSize, duplicationThreshold, maxChainLen)
    tic
    DEBUG = 0;
    maxOverlapRestricted = round((7 / 8) * windowSize);
    maxOverlapRelaxed = round((1 / 2) * windowSize);
    
    chainsFromED = [];
    chainsFromDTW = [];
    
    for iSeed = 1 : length(seedPositions)
        currentSeed = seedPositions(iSeed);
        if DEBUG == 2
            iSeed
        end
        nearestNeighborListED = getNearestNeighborList(timeSeries, currentSeed, windowSize, 1, chainsFromED, maxChainLen);
        if DEBUG == 1
            nearestNeighborListED
        end
        nearestNeighborListDTW = getNearestNeighborList(timeSeries, currentSeed, windowSize, 0, chainsFromDTW, maxChainLen);
        if DEBUG == 1
            nearestNeighborListDTW
        end
        chainsFromED(iSeed).chain = nearestNeighborListED;
        chainsFromED(iSeed).count = 1;
        chainsFromDTW(iSeed).chain = nearestNeighborListDTW;
        chainsFromDTW(iSeed).count = 1;
    end
    
    if duplicationThreshold > 1
        chainsFromED = generateRecurrenceCount(chainsFromED, maxOverlapRelaxed);
        chainsFromDTW = generateRecurrenceCount(chainsFromDTW, maxOverlapRelaxed);
    end
    
    detectedEventsFromED = getDetectedEventsFromChains(chainsFromED, seedPositions, maxOverlapRestricted, duplicationThreshold);
    if DEBUG == 1
        detectedEventsFromED
    end
    detectedEventsFromDTW = getDetectedEventsFromChains(chainsFromDTW, seedPositions, maxOverlapRestricted, duplicationThreshold);
    if DEBUG == 1
        detectedEventsFromDTW
    end
    
    detectedEvents = [detectedEventsFromED detectedEventsFromDTW];
    if DEBUG == 1
        detectedEvents
    end
    filteredDetectedEvents = deDuplicate(detectedEvents, maxOverlapRestricted);
    if DEBUG == 1
        filteredDetectedEvents
    end
    toc
end