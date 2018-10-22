

function filteredEventList = deDuplicate (eventList, seedLength)

    filteredEventList = [];
    if length(eventList) > 0
        maxOverlap = (7/8)*seedLength;
        totalEvent = length(eventList);
        eventList = sort(eventList);
        filteredEventList = [filteredEventList eventList(1)];
    
        for iPos = 2 : totalEvent
            if abs(eventList(iPos) - filteredEventList(end)) > maxOverlap
                filteredEventList = [filteredEventList eventList(iPos)];
            end
        end 
    end
end