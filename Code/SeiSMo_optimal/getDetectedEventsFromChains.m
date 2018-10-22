function detectedEvents = getDetectedEventsFromChains(chains, seedPositions, maxOverlap, duplicationThreshold)

    detectedEvents = [];
    for iPos = 1: length(chains)
        iChain = chains(iPos).chain;
        iCount = chains(iPos).count;
        
        if iCount >= duplicationThreshold
            for jPos = 1 : length(iChain)
                if isDuplicate(seedPositions, iChain(jPos), maxOverlap) == 0
                    detectedEvents = [detectedEvents iChain(jPos)];
                end
            end
        end
    end
end
