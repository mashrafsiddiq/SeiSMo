function duplicateFound = isDuplicate(eventList, newEvent, overlapPoints)

    % overlapPoints = 350;
    duplicateFound = 0;
    for iEvent = 1 : length(eventList)
        if abs(eventList(iEvent) - newEvent) < overlapPoints
            duplicateFound = 1;
            break;
        end
    end
end