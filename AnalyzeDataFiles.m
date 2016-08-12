function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = AnalyzeDataFiles(FiberPhotometryFile, MouseLocationFile, FiberPhotometryHz, MouseVisualizationHz, EndTime, StartTime, ReductionLayers, PeakCutoff, WindowSize)
%This function should run all the other ones and return all the information
%needed, the user should only have to run this one function

%Get needed data in correct format
[LeftRightData, FiberData] = GetDataFromFiles(MouseLocationFile, FiberPhotometryFile);
%If some variables haven't been entered set them to default values
if nargin < 9
  WindowSize = 5;
end
if nargin < 8
  PeakCutoff = .5;
end
if nargin < 7
  ReductionLayers = 0;
end
if nargin < 6
  StartTime = 0;
end
if nargin < 5
  EndTime = min(length(LeftRightData)/MouseVisualizationHz, length(FiberData)/FiberPhotometryHz);
end
FiberEndIndex = round(FiberPhotometryHz*EndTime);
FiberStartIndex = round(max(FiberPhotometryHz*StartTime,1));
LRStartIndex = round(max(MouseVisualizationHz*StartTime,1));
LREndIndex = round(MouseVisualizationHz*EndTime);
%actual function is here
if ReductionLayers > 0
  smoothFiberData = ReduceNoise(ReductionLayers, WindowSize, FiberData);
end
timeStampedFiberData = GetTimeStamps(FiberPhotometryHz, FiberData, 0);
peakMarkedFiberData = FindPeaks(PeakCutoff, FiberData, 10, FiberPhotometryHz);
GetPeakTimes(peakMarkedFiberData)
[LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = RelateSideToNeuronActivity(FiberData, FiberPhotometryHz, LeftRightData, MouseVisualizationHz)
x = timeStampedFiberData(1,FiberStartIndex:FiberEndIndex);
y = timeStampedFiberData(2,FiberStartIndex:FiberEndIndex);
f = LeftRightData(1,LRStartIndex:LREndIndex);
g = LeftRightData(2,LRStartIndex:LREndIndex);
h = LeftRightData(3,LRStartIndex:LREndIndex);
plot(x,y)
hold on;
lplot = area(f,g)
rplot = area(f,h)
lplot(1).FaceColor = [1,1,0];
rplot(1).FaceColor = [1,0,1];
legend('Voltage', 'Left', 'Right');
hold off;
end

