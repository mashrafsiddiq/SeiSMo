## SeiSMo: Semi-supervised Time Series Motif Discovery for Seismic Signal Detection

This is the code base for the paper titled, "**SeiSMo: Semi-supervised Time Series Motif Discovery for Seismic Signal Detection**". To run the SeiSMo code:

1. Go to **Data** directory, load synthetic or Northern California data in Matlab.
2. Go to **Code/SeiSMo** directory
3. Run the command:
      For synthetic: 
      ```
      new_detect = SeiSMo(timeSeries, seedPositions, 200, 2, 10)
      ```
      For northern California: 
      ```
      new_detect = SeiSMo(timeSeries, seedPositions, 400, 2, 10)
      ```
      
**new_detect** will have the list of newly detected events by SeiSMo.To plot them, use 200 as window length for synthetic data and 400 for northern california data.

Contact: M Ashraf Siddiquee <siddiquee@unm.edu>
