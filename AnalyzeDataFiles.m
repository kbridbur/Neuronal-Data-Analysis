function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes] = AnalyzeDataFiles(FiberPhotometryFile, MouseLocationFile, FiberPhotometryHz, MouseVisualizationHz, ReductionLayers, PeakCutoff, WindowSize, StartTime, EndTime)
%This function should run all the other ones and return all the information
%needed, the user should only have to run this one function
[LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, LeftTimeSpent, CenterTimeSpent, RightTimeSpent] = RelateSideToNeuronActivity(...);

end

