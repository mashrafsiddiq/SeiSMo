function duplicateFound = isDuplicate(eventList, newEvent, maxOverlapPoints)

    duplicateFound = 0;
    for iEvent = 1 : length(eventList)
        if abs(eventList(iEvent) - newEvent) < maxOverlapPoints
            duplicateFound = 1;
            break;
        end
    end
end