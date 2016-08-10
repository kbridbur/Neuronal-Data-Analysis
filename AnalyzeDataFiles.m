function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = AnalyzeDataFiles(FiberPhotometryFile, MouseLocationFile, FiberPhotometryHz, MouseVisualizationHz, StartTime, EndTime, ReductionLayers, PeakCutoff, WindowSize)
%This function should run all the other ones and return all the information
%needed, the user should only have to run this one function

%Get needed data in correct format
[num, ~, ~] = xlsread(MouseLocationFile, 'A:N');
convertTDMS(1, FiberPhotometryFile);
%do something to read the FiberPhotometry file
%FiberData = ;

%If some variables haven't been entered set them to default values
if ~exist(ReductionLayers, 'var')
  ReductionLayers = 0;
end
if ~exist(WindowSize, 'var')
  WindowSize = 5;
end
if ~exist(PeakCutoff, 'var')
  PeakCutoff = 1;
end
if ~exist(StartTime, 'var')
 StartTime = 0; 
end
if ~exist(EndTime 'var')
 EndTime = Length(MouseLocationMatrix)*MouseVisualizationHz;
end

%actual function is here
if ReductionLayers > 0
  smoothFiberData = ReduceNoise(ReductionLayers, WindowSize, FiberData);
end
a = num(:,[1, 13:14]);
b = rot90(a);
LeftRightData = flipud(b);
timpStampedFiberData = GetTimeStamps(FiberPhotometryHz, FiberData, 0);
peakMarkedFiberData = FindPeaks(PeakCutoff, FiberData, 10, FiberPhotometryHz);
[LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = RelateSideToNeuronActivity(FiberData, FiberPhotoMetryHz, LeftRightData, MouseVisualizationHz);
%plot the data
end

