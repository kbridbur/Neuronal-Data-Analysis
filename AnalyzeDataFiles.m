function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes] = AnalyzeDataFiles(FiberPhotometryFile, MouseLocationFile, FiberPhotometryHz, MouseVisualizationHz, StartTime, EndTime, ReductionLayers, PeakCutoff, WindowSize)
%This function should run all the other ones and return all the information
%needed, the user should only have to run this one function
MouseLocationMatrix = ;%load some stuff

%If some variables haven't been entered set them to default values
if exist(ReductionLayers) < 2
  ReductionLayers = 0;
end
if exist(WindowSize) < 2
  WindowSize = 3;
end
if exist(PeakCutoff) <2
  PeakCutoff = 1;
end
if exist(StartTime)
 StartTime = 0; 
end
if exist(EndTime)
 EndTime = Length(MouseLocationMatrix)*MouseVisualizationHz;
end
[LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = RelateSideToNeuronActivity(...);

end

