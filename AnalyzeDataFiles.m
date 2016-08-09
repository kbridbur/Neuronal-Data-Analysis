function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = AnalyzeDataFiles(FiberPhotometryFile, MouseLocationFile, FiberPhotometryHz, MouseVisualizationHz, StartTime, EndTime, ReductionLayers, PeakCutoff, WindowSize)
%This function should run all the other ones and return all the information
%needed, the user should only have to run this one function
[num, ~, ~] = xlsread(MouseLocationFile, 'A:N');
convertTDMS(1, FiberPhotometryFile);
%do something to read the FiberPhotometry file
%FiberData = ;
%If some variables haven't been entered set them to default values
if exist(ReductionLayers, 'var') < 2
  ReductionLayers = 0;
end
if exist(WindowSize, 'var') < 2
  WindowSize = 3;
end
if exist(PeakCutoff, 'var') <2
  PeakCutoff = 1;
end
if exist(StartTime, 'var')
 StartTime = 0; 
end
if exist(EndTime 'var')
 EndTime = Length(MouseLocationMatrix)*MouseVisualizationHz;
end
LeftRightData = num(:,[1, 13:14]);
timpStampedFiberData = GetTimeStamps(FiberPhotometryHz, FiberData, 0);
peakMarkedFiberData = FindPeaks(PeakCutoff, FiberData, 10);
[LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = RelateSideToNeuronActivity(FiberData, FiberPhotoMetryHz, LeftRightData, MouseVisualizationHz);
end

