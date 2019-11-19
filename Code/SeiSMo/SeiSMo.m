function filteredDetectedEvents = SeiSMo(timeSeries, seedPositions, windowSize, duplicationThreshold, maxChainLen)
    tic
    DEBUG = 1;
    LOG = 1;
    maxOverlapRestricted = round((7 / 8) * windowSize);
    maxOverlapRelaxed = round((1 / 2) * windowSize);
    
    for iSeed = 1 : length(seedPositions)
        currentSeed = seedPositions(iSeed);
        if DEBUG == 1
            iSeed
        end
        nearestNeighborListED = getNearestNeighborList(timeSeries, currentSeed, windowSize, 1, maxChainLen);
        if DEBUG == 1
            nearestNeighborListED
        end
        nearestNeighborListDTW = getNearestNeighborList(timeSeries, currentSeed, windowSize, 0, maxChainLen);
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
        disp('detectedEventsFromED')
        detectedEventsFromED
    end
    detectedEventsFromDTW = getDetectedEventsFromChains(chainsFromDTW, seedPositions, maxOverlapRestricted, duplicationThreshold);
    if DEBUG == 1
        disp('detectedEventsFromDTW')
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
    
    if LOG == 1
        for posED = 1 : length(chainsFromED)
            posED
            [length(chainsFromED(posED).chain) chainsFromED(posED).count]
        end
        for posDTW = 1 : length(chainsFromDTW)
            posDTW
            [length(chainsFromDTW(posDTW).chain) chainsFromDTW(posDTW).count]
        end
        detectedEvents
        filteredDetectedEvents
    end
    
    toc
end
