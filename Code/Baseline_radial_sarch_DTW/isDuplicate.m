function duplicateFound = isDuplicate(eventList, newEvent, overlapPoints)

    % overlapPoints = round((7/8)*seedLength);
    duplicateFound = 0;
    for iEvent = 1 : length(eventList)
        if abs(eventList(iEvent) - newEvent) < overlapPoints
            duplicateFound = 1;
            break;
        end
    end
end