
function filteredEventList = deDuplicate (eventList, maxOverlap)

    filteredEventList = [];
    if length(eventList) > 0
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