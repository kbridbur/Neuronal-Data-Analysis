function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes, TotalTimeLeft, TotalTimeCenter, TotalTimeRight] = RelateSideToNeuronActivity(ActivityList, ActivityHz, SideList, SideHz)
%Analyses data and outputs relations between activity and mouse location
LeftIndexList = [];
CenterIndexList = [];
RightIndexList = [];
numLeft = 0;
LeftAvgActivity = 0;
numCenter = 0;
CenterAvgActivity = 0;
numRight = 0;
RightAvgActivity = 0;
for i = 1:Length(SideList) %Check if the mouse was on the left right or center and add the activity at that timepoint to the total activity on that side
  equivalentActivityIndex = round(SideHz/ActivityHz, 0);
  if SideList(1, i) = 0 & SideList(2, i) = 0
    CenterIndexList = [CenterIndexList equivalentActivityIndex];
    numCenter = numCenter + 1;
    CenterAvgActivity = CenterAvgActivity + ActivityList(1, equivalentActivityIndex);
  end
  if SideList(1, i) = 1
    LeftIndexList = [RightIndexList equivalentActivityIndex];
    numLeft = numLeft + 1;
    LeftAvgActivity = LeftAvgActivity + ActivityList(1, equivalentActivityIndex);
  end
  if SideList(2, i) = 1
    RightIndexList = [RightIndexList equivalentActivityIndex];
    numRight = numRight + 1;
    RightAvgActivity = RightAvgActivity + ActivityList(1, equivalentActivityIndex);
  end  
end
%Turn the totals into averages
LeftAvgActivity = LeftAvgActivity/numLeft;
CenterAvgActivity = CenterAvgActivity/numCenter;
RightAvgActivity = RightAvgActivity/numRight;

%Find number of unique activity peaks in each location
PeakList = FindPeaks(1, ActivityList);
LeftNumSpikes = NumUniquePeaks(LeftIndexList, PeakList);
CenterNumSpikes = NumUniquePeaks(CenterIndexList, PeakList);
RightNumSpikes = NumUniquePeaks(RightIndexList, PeakList);

%Calculate total time spent in each area
indexConstant = 1/SideHz;
TotalTimeLeft = numLeft * indexConstant;
TotalTimeCenter = numCenter * indexConstant;
TotalTimeRight = numRight * indexConstant;
end