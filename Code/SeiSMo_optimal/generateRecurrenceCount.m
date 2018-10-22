function detectedEvents = generateRecurrenceCount(detectedEvents, maxOverlap)

    for iPos = 1 : length(detectedEvents)
        iChain = detectedEvents(iPos).chain;
        iCount = detectedEvents(iPos).count;
        iChainLen = length(iChain);
        
        for jPos = 1 : length(detectedEvents)
            if iPos == jPos
                continue;
            end
           
            jChain = detectedEvents(jPos).chain;
            jChainLen = length(jChain);
            if isDuplicate([iChain(iChainLen) iChain(iChainLen - 1)], jChain(jChainLen), maxOverlap) == 1 || isDuplicate([iChain(iChainLen) iChain(iChainLen - 1)], jChain(jChainLen - 1), maxOverlap) == 1
                iCount = iCount + 1;
            end 
        end
        detectedEvents(iPos).count = iCount;
    end
end