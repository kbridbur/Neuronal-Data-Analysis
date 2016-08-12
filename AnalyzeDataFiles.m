function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = AnalyzeDataFiles(FiberPhotometryFile, MouseLocationFile, FiberPhotometryHz, MouseVisualizationHz, StartTime, EndTime, ReductionLayers, PeakCutoff, WindowSize)
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
  EndTime = length(LeftRightData)*MouseVisualizationHz;

end
if nargin < 5
  StartTime = 0; 
end

%actual function is here
if ReductionLayers > 0
  smoothFiberData = ReduceNoise(ReductionLayers, WindowSize, FiberData);
end
timeStampedFiberData = GetTimeStamps(FiberPhotometryHz, FiberData, 0);
peakMarkedFiberData = FindPeaks(PeakCutoff, FiberData, 10, FiberPhotometryHz);
GetPeakTimes(peakMarkedFiberData)
[LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = RelateSideToNeuronActivity(FiberData, FiberPhotometryHz, LeftRightData, MouseVisualizationHz)
x = timeStampedFiberData(1,:);
y = timeStampedFiberData(2,:);
plot(x,y)
end

