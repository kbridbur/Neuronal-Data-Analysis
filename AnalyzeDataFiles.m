function [leftAvgActivity, centerAvgActivity, rightAvgActivity, leftNumSpikes, centerNumSpikes, rightNumSpikes, leftTimeSpent, centerTimeSpent, rightTimeSpent] = AnalyzeDataFiles(fiberData, leftRightData, fiberPhotometryHz, mouseVisualizationHz, endTime, startTime, reductionLayers, peakCutoff, windowSize)
%Summation of all the other functions, puts everything together

%If some variables haven't been entered set them to default values
if nargin < 9
  windowSize = 11;
end
if nargin < 8
  peakCutoff = 1.3;
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
fiberData = fiberData(:, fiberStartIndex:fiberEndIndex);
leftRightData = leftRightData(:,LRStartIndex:LREndIndex); 
%actual function is here
if reductionLayers > 0
  smoothFiberData = ReduceNoise(reductionLayers, windowSize, fiberData);
  peakMarkedFiberData = FindPeaks(peakCutoff, smoothFiberData);
end
if reductionLayers <= 0
  peakMarkedFiberData = FindPeaks(peakCutoff, fiberData);
end
timeStampedFiberData = GetTimeStamps(fiberPhotometryHz, fiberData, 0, startTime);
maximum = max(peakMarkedFiberData(2,:));
peakTimes = GetPeakTimes(peakMarkedFiberData, fiberPhotometryHz);
[leftAvgActivity, centerAvgActivity, rightAvgActivity, leftNumSpikes, centerNumSpikes, rightNumSpikes, leftTimeSpent, centerTimeSpent, rightTimeSpent] = RelateSideToNeuronActivity(fiberData, fiberPhotometryHz, leftRightData, mouseVisualizationHz);
statsMatrix = {'0', 'Left', 'Center', 'Right'; 'Activity', leftAvgActivity, centerAvgActivity, rightAvgActivity;'Peaks', leftNumSpikes, centerNumSpikes, rightNumSpikes;'Time', leftTimeSpent, centerTimeSpent, rightTimeSpent}
x = timeStampedFiberData(1,:);
y = timeStampedFiberData(2,:);
w = find(~isnan(peakMarkedFiberData(1,:)));
for i = 1:length(w)
  w(1,i) = w(1,i)/fiberPhotometryHz+startTime;
end
z = peakMarkedFiberData(2,:);
f = leftRightData(1,:);
g = leftRightData(2,:);
h = leftRightData(3,:);
figure()
lplot = area(f,g);
hold on;
rplot = area(f,h);
lplot(1).FaceColor = [1,1,0];
rplot(1).FaceColor = [1,0,1];
plot(x,y,'LineWidth', 2)
plot(w,z,'k', 'LineWidth', 2)
hold off;
axis([startTime endTime 0 maximum*1.1]);
title(['Fiber Data from ', int2str(startTime/10), 's to ', int2str(endTime/10), 's']);
xlabel('Time in Seconds*10');
ylabel('Voltage');
legend('Right', 'Left', 'Voltage', 'Peaks');
WriteToFile(timeStampedFiberData, peakTimes, statsMatrix);
end

