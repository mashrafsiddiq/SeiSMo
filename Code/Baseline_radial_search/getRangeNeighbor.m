%% This function finds nearest neighbour of a query from a time series
%% Uses MASS_V2 algorithm to find the nearest neighbor

function rangeNeighborIndex = getRangeNeighbor(timeSeries, queryPosition, queryLength, range)

    % Extract the exact query
    query = timeSeries(queryPosition : queryPosition + queryLength - 1);
    
    % Replace the query by Gaussian random number
    timeSeries(queryPosition : queryPosition + queryLength - 1) = randn(1, queryLength);
    
    % Find the Euclidian distance fro the query
    eDistance = MASS_V2(timeSeries, query);
    
    % Get all distances within the range radious
    newEventPositionList = find(eDistance < range);
    
    % Eliminate duplicate events
    newEventPositionList = deDuplicate(newEventPositionList, queryLength);
    
    rangeNeighborIndex = newEventPositionList;
end