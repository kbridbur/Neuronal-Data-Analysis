%run everything from here.
%Either specify file paths or you will be prompted to select the two files
%you wish to analyze
[LeftRightData, FiberData] = GetDataFromFiles('ExampleRawData.xlsx', 'ExampleFiberPhotomertyData.tdms');

%The arguments for AnalyzeDataFiles are as follows:
%-FiberData, (required) Obtained by running GetDataFromFiles with the desired file 
%-LeftRightData, (required) Obtained by running GetDataFromFiles with the desired file
%-FiberPhotometryHz, (required) Hz at which the Fiber Photometry runs
%-MouseVisualizationHz, (required) Hz at which the arena video runs
%-EndTime, (optional) Defaults to the end of the data, Time you want the graph to stop (300 = 30 seconds)
%-StartTime, (optional) Defaults to 0, Time you want the graph to begin
%-ReductionLayers, (optional) Defaults to 0, layers of noise reduction
%-PeakCutoff, (optional) Defaults to .5, number of std devs above the
%average you want to be the cutoff for determining peaks
%-WindowSize, (optional) size of averaging window used in noise reduction

AnalyzeDataFiles(FiberData, LeftRightData, 100, 10);