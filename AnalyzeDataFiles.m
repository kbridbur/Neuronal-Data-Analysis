function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = AnalyzeDataFiles(FiberData, LeftRightData, FiberPhotometryHz, MouseVisualizationHz, EndTime, StartTime, ReductionLayers, PeakCutoff, WindowSize)
%This function should run all the other ones and return all the information
%needed, the user should only have to run this one function

%Get needed data in correct format
%[LeftRightData, FiberData] = GetDataFromFiles(MouseLocationFile, FiberPhotometryFile);
%If some variables haven't been entered set them to default values
if nargin < 9
  WindowSize = 11;
end
if nargin < 8
  PeakCutoff = 1.2;
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
  timeStampedFiberData = GetTimeStamps(FiberPhotometryHz, smoothFiberData, 0);
  peakMarkedFiberData = FindPeaks(PeakCutoff, smoothFiberData, FiberPhotometryHz);
end
if ReductionLayers == 0
  timeStampedFiberData = GetTimeStamps(FiberPhotometryHz, FiberData, 0);
  peakMarkedFiberData = FindPeaks(PeakCutoff, FiberData, FiberPhotometryHz);
end
maximum = max(peakMarkedFiberData(3,:));
GetPeakTimes(peakMarkedFiberData);%
[LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = RelateSideToNeuronActivity(FiberData, FiberPhotometryHz, LeftRightData, MouseVisualizationHz)
length(peakMarkedFiberData)
length(FiberData)
x = timeStampedFiberData(1,FiberStartIndex:FiberEndIndex);
y = timeStampedFiberData(2,FiberStartIndex:FiberEndIndex);
z = peakMarkedFiberData(3, FiberStartIndex:FiberEndIndex);
f = LeftRightData(1,LRStartIndex:LREndIndex);
g = LeftRightData(2,LRStartIndex:LREndIndex);
h = LeftRightData(3,LRStartIndex:LREndIndex);
figure()
lplot = area(f,g)
hold on;
rplot = area(f,h)
lplot(1).FaceColor = [1,1,0];
rplot(1).FaceColor = [1,0,1];
plot(x,y,'LineWidth', 2)
plot(x,z,'k', 'LineWidth', 2)
hold off;
axis([StartTime EndTime 0 maximum*1.1]);
title(['Fiber Data from ', int2str(StartTime/10), 's to ', int2str(EndTime/10), 's']);
xlabel('Time in Seconds*10');
ylabel('Voltage');
legend('Right', 'Left', 'Voltage', 'Peaks');
end

