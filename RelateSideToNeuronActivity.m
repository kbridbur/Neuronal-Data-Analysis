function [LeftAvgActivity, CenterAvgActivity, RightAvgActivity, LeftNumSpikes, CenterNumSpikes, RightNumSpikes] = RelateSideToNeuronActivity(ActivityList, ActivityHz, SideList, SideHz)
%Analyses data and outputs relations between activity and mouse location
PeakList = FindPeaks(1, ActivityList);
numLeft = 0;
LeftAvgActivity = 0;
numCenter = 0;
CenterAvgActivity = 0;
numRight = 0;
RightAvgActivity = 0;
for i = 1:Length(SideList) %Check if the mouse was on the left right or center and add the activity at that timepoint to the total activity on that side
  equivalentActivityIndex = round(SideHz/ActivityHz, 0);
  if SideList(1, i) = 0 & SideList(2, i) = 0
    numCenter = numCenter + 1;
    CenterAvgActivity = CenterAvgActivity + ActivityList(1, equivalentActivityIndex);
  end
  if SideList(1, i) = 1
    numLeft = numLeft + 1;
    LeftAvgActivity = LeftAvgActivity + ActivityList(1, equivalentActivityIndex);
  end
  if SideList(2, i) = 1
    numRight = numRight + 1;
    RightAvgActivity = RightAvgActivity + ActivityList(1, equivalentActivityIndex);
  end  
end
%Turn the totals into averages
LeftAvgActivity = LeftAvgActivity/numLeft;
CenterAvgActivity = CenterAvgActivity/numCenter;
RightAvgActivity = RightAvgActivity/numRight;

end
