function uniqueNewEventList = baselineMotifSearch_2(timeSeries, seedLength, seedPositions, allEvents, radious, output_file_name)
    tic
    numberOfSeeds = length(seedPositions);
    % seedLength = 400;
    newEventMaxOverlap = round((350 / 400) * seedLength) ;
    newEventList = [];
    
    % Perform radial search for each seed
    for iSeed = 1 : numberOfSeeds
        newEventFromThisSeed = getRangeNeighbor(timeSeries, seedPositions(iSeed), seedLength, radious);
        for currentNewEvent = 1 : length(newEventFromThisSeed)
            if isDuplicate(allEvents, newEventFromThisSeed(currentNewEvent), newEventMaxOverlap) == 0
                newEventList = [newEventList newEventFromThisSeed(currentNewEvent)];
            end
        end
    end
    % Deduplicate the events using max 12.5% overlap
    uniqueNewEventList = deDuplicate(newEventList, seedLength);
    save(output_file_name);
    toc
end