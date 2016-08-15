%Either specify file paths or you will be prompted to select the two files
%you wish to analyze
[LeftRightData, FiberData] = GetDataFromFiles();

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

AnalyzeDataFiles(FiberData, LeftRightData, 100, 10, 100, 0, 100);
%If you'd like to see multiple sections of the data its more efficient to
%write multiple AnalyzeDataFiles here as the data will only need to load
%once


%V1.0.0 Kyle Bridburg 2016-08-15
%https://github.com/kbridbur
%Creates basic functionality
%Known Bugs: Smoothing data causes the data to shift to the right on the
%graph, FindPeaks does not work for some values of sectioning and indexes
%incorrectly in those cases, GetPeakTimes creates multiple duplicates of
%the same time ~36.