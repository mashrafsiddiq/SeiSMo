function wrapper()

    %% Load the data. The data file should contain timeSeries, queryPosition and queryLength
    load('data.mat');

    %% Generate result for ED
    [ED_chain_it_1, ED_sink_it_1, iterativeInc] = chainNN_V3(timeSeries, seedPositions, 1, 400);
    ED_chain_it_1
    ED_sink_it_1
    [ED_chain_it_2, ED_sink_it_2, iterativeInc] = chainNN_V3(timeSeries, [seedPositions ED_chain_it_1 ED_sink_it_1], 1, seedLength);
    ED_chain_it_2
    %% Generate result for DTW
    [DTW_chain_it_1, DTW_sink_it_1, iterativeInc] = chainNN_V3(timeSeries, seedPositions, 0, seedLength);
    DTW_chain_it_1
    [DTW_chain_it_2, DTW_sink_it_2, iterativeInc] = chainNN_V3(timeSeries, [seedPositions DTW_chain_it_1 DTW_sink_it_1], 0, seedLength);
    DTW_chain_it_2

    %% Merge all the new events
    UNFILTERED_result = [ED_chain_it_1 ED_sink_it_1 ED_chain_it_2 ED_sink_it_2, DTW_chain_it_1 DTW_sink_it_1 DTW_chain_it_2 DTW_sink_it_2];
    UNFILTERED_result
    %% Deduplicate the results
    FILTERED_result = deDuplicate(UNFILTERED_result, seedLength);
    FILTERED_result
    
    save('results');
quit;