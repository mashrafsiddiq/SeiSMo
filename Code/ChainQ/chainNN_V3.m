%% ChainNN algorithm tries to discover motifs in a time series with the 
%% help of some given motifs.
%% Options to use both DTW and MASS

function [newEventsFromChain, newEventsFromSink, iterativeInc] = chainNN_V3(timeSeries, seedPositions, useMASS, seedLength)

    tic;
    % useMASS = 0;
    % Length of each seed or catalog event
    % seedLength = 400;  
    % overlapFactor 2 here means 50% overlap between two windows
    overlapFactor = 2;
    maxOverlap = round(7 / 8 * seedLength);
    % Newly discovered events will be stored here
    newEventsFromChain = [];
    newEventsFromSink = [];
    iterativeInc = [];
    % This temporary array will be used to store chain of nearest neighbors
    chainOfEventList = [];        
    numberOfSeeds = length(seedPositions);
    sinkEventsList = [];
    
    for iSeed = 1 : length(seedPositions)

        % nearestNeighborIndexList will be used to store index of nearest neighbors temporarily
        nearestNeighborIndexList = [];
        
        nearestNeighborCount = 0;
        currentSeedPosition = seedPositions(iSeed);
        
        % Flag to check if a sync is found
        isSinkFound = 0;
        
        % Continue until a sink is found
        while isSinkFound == 0

            % Compute nearest neighbour using MASS_V2
            nearestNeighborIndex = getNearestNeighbor(timeSeries, currentSeedPosition, seedLength, useMASS); 
            
            % Check if the nearest neighbor already belongs to the list of seeds
            seedEventFound = 0;
            for kSeed = 1 : numberOfSeeds
                if abs(seedPositions(kSeed) - nearestNeighborIndex) < (seedLength / overlapFactor)
                    % Nearest neighbor belongs to the seed list (using 50% overlap)
                    seedEventFound = 1;
                end
            end

            % Do not proceed further if the nearest neighbor belongs to the seed list
            if seedEventFound == 1
                break;
            % Otherwise proceed
            else
                % Put the nearest neighbor in the list and update the currentSeedPosition for next search
                nearestNeighborIndexList = [nearestNeighborIndexList nearestNeighborIndex];
                currentSeedPosition = nearestNeighborIndex;
                nearestNeighborCount = nearestNeighborCount + 1;
                if length(nearestNeighborIndexList) > 2
                    currentChainLength = length(nearestNeighborIndexList);
                    if abs(nearestNeighborIndexList(currentChainLength) - nearestNeighborIndexList(currentChainLength - 2)) < (seedLength / overlapFactor)
                        % We found a sink
                        sinkEventsList = nearestNeighborIndexList(currentChainLength - 1 : currentChainLength);
                        isSinkFound = 1;
                    end
                end 
            end
        end
        
        % If the chain contains seed events on both of the sides, take all the inner events as newly discovered events
        if seedEventFound == 1
            for currNearestNeighbor = 1 : length(nearestNeighborIndexList)
                if isDuplicate(newEventsFromChain, nearestNeighborIndexList(currNearestNeighbor), maxOverlap) == 0 && isDuplicate(newEventsFromSink, nearestNeighborIndexList(currNearestNeighbor), maxOverlap) == 0
                    newEventsFromChain = [newEventsFromChain nearestNeighborIndexList(currNearestNeighbor)];
                end
            end
        % Otherwise keep the chain for future processing
        else 
            
            [rChainOfEventList, cChainOfEventList] = size(chainOfEventList);
            
            % Take last two possible events from each chain and check for match
            % if any event mathes with an event from a different chain, list it as
            % a newly discovered event
            for iRow = 1 : rChainOfEventList
                
                if abs(chainOfEventList(iRow, cChainOfEventList - 1) - sinkEventsList(1)) < (seedLength / overlapFactor)
                    if isDuplicate(newEventsFromSink, sinkEventsList(1), maxOverlap) == 0 && isDuplicate(newEventsFromChain, sinkEventsList(1), maxOverlap) == 0
                        newEventsFromSink = [newEventsFromSink sinkEventsList(1)];
                    end   
                end
                
                if abs(chainOfEventList(iRow, cChainOfEventList - 1) - sinkEventsList(2)) < (seedLength / overlapFactor)
                    if isDuplicate(newEventsFromSink, sinkEventsList(2), maxOverlap) == 0 && isDuplicate(newEventsFromChain, sinkEventsList(2), maxOverlap) == 0
                        newEventsFromSink = [newEventsFromSink sinkEventsList(2)];
                    end
                end
                
                if abs(chainOfEventList(iRow, cChainOfEventList) - sinkEventsList(1)) < (seedLength / overlapFactor)
                    if isDuplicate(newEventsFromSink, sinkEventsList(1), maxOverlap) == 0 && isDuplicate(newEventsFromChain, sinkEventsList(1), maxOverlap) == 0
                        newEventsFromSink = [newEventsFromSink sinkEventsList(1)];
                    end
                end
                
                if abs(chainOfEventList(iRow, cChainOfEventList) - sinkEventsList(2)) < (seedLength / overlapFactor)
                    if isDuplicate(newEventsFromSink, sinkEventsList(2), maxOverlap) == 0 && isDuplicate(newEventsFromChain, sinkEventsList(2), maxOverlap) == 0
                        newEventsFromSink = [newEventsFromSink sinkEventsList(2)];
                    end 
                end
            end
            
            chainOfEventList = [chainOfEventList; sinkEventsList];
        end
        
        % Print current seed position as a log
        iSeed
        iterativeInc = [iterativeInc; [length(newEventsFromChain) length(newEventsFromSink)]];
    end
    toc;
end
