function [leftAvgActivity, centerAvgActivity, rightAvgActivity, leftNumSpikes, centerNumSpikes, rightNumSpikes, leftTimeSpent, centerTimeSpent, rightTimeSpent] = AnalyzeDataFiles(fiberData, leftRightData, fiberPhotometryHz, mouseVisualizationHz, endTime, startTime, reductionLayers, peakCutoff, windowSize)
%This function should run all the other ones and return all the information
%needed, the user should only have to run this one function

%Get needed data in correct format
%[LeftRightData, FiberData] = GetDataFromFiles(MouseLocationFile, FiberPhotometryFile);
%If some variables haven't been entered set them to default values
if nargin < 9
  windowSize = 11;
end
if nargin < 8
  peakCutoff = 1.2;
end
if nargin < 7
  reductionLayers = 0;
end
if nargin < 6
  startTime = 0;
end
if nargin < 5
  endTime = min(length(leftRightData)/mouseVisualizationHz, length(fiberData)/fiberPhotometryHz);
end
fiberEndIndex = round(fiberPhotometryHz*endTime);
fiberStartIndex = round(max(fiberPhotometryHz*startTime,1));
LRStartIndex = round(max(mouseVisualizationHz*startTime,1));
LREndIndex = round(mouseVisualizationHz*endTime);
%actual function is here
if reductionLayers > 0
  smoothFiberData = ReduceNoise(reductionLayers, windowSize, fiberData);
  timeStampedFiberData = GetTimeStamps(fiberPhotometryHz, smoothFiberData, 0);
  peakMarkedFiberData = FindPeaks(peakCutoff, smoothFiberData, fiberPhotometryHz);
end
if reductionLayers == 0
  timeStampedFiberData = GetTimeStamps(fiberPhotometryHz, fiberData, 0);
  peakMarkedFiberData = FindPeaks(peakCutoff, fiberData, fiberPhotometryHz);
end
maximum = max(peakMarkedFiberData(3,:));
GetPeakTimes(peakMarkedFiberData);%
[leftAvgActivity, centerAvgActivity, rightAvgActivity, leftNumSpikes, centerNumSpikes, rightNumSpikes, leftTimeSpent, centerTimeSpent, rightTimeSpent] = RelateSideToNeuronActivity(fiberData, fiberPhotometryHz, leftRightData, mouseVisualizationHz)
length(peakMarkedFiberData)
length(fiberData)
x = timeStampedFiberData(1,fiberStartIndex:fiberEndIndex);
y = timeStampedFiberData(2,fiberStartIndex:fiberEndIndex);
z = peakMarkedFiberData(3, fiberStartIndex:fiberEndIndex);
f = leftRightData(1,LRStartIndex:LREndIndex);
g = leftRightData(2,LRStartIndex:LREndIndex);
h = leftRightData(3,LRStartIndex:LREndIndex);
figure()
lplot = area(f,g)
hold on;
rplot = area(f,h)
lplot(1).FaceColor = [1,1,0];
rplot(1).FaceColor = [1,0,1];
plot(x,y,'LineWidth', 2)
plot(x,z,'k', 'LineWidth', 2)
hold off;
axis([startTime endTime 0 maximum*1.1]);
title(['Fiber Data from ', int2str(startTime/10), 's to ', int2str(endTime/10), 's']);
xlabel('Time in Seconds*10');
ylabel('Voltage');
legend('Right', 'Left', 'Voltage', 'Peaks');
end

