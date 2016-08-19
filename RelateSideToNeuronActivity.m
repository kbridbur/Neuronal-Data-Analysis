function [leftAvgActivity, centerAvgActivity, rightAvgActivity, leftNumSpikes, centerNumSpikes, rightNumSpikes, totalTimeLeft, totalTimeCenter, totalTimeRight] = RelateSideToNeuronActivity(activityList, activityHz, sideList, sideHz)
%Analyses data and outputs relations between activity and mouse location
leftIndexList = [];
centerIndexList = [];
rightIndexList = [];
numLeft = 0;
leftAvgActivity = 0;
numCenter = 0;
centerAvgActivity = 0;
numRight = 0;
rightAvgActivity = 0;
for i = 1:length(sideList) %Check if the mouse was on the left right or center and add the activity at that timepoint to the total activity on that side
  equivalentActivityIndex = max(1, i*round(activityHz/sideHz, 0));
  if sideList(3, i) == 0 && sideList(2, i) == 0
    centerIndexList = [centerIndexList equivalentActivityIndex];
    numCenter = numCenter + 1;
    centerAvgActivity = centerAvgActivity + activityList(1, equivalentActivityIndex);
  end
  if sideList(3, i) == 1
    leftIndexList = [leftIndexList equivalentActivityIndex];
    numLeft = numLeft + 1;
    leftAvgActivity = leftAvgActivity + activityList(1, equivalentActivityIndex);
  end
  if sideList(2, i) == 1
    rightIndexList = [rightIndexList equivalentActivityIndex];
    numRight = numRight + 1;
    rightAvgActivity = rightAvgActivity + activityList(1, equivalentActivityIndex);
  end  
end
%Turn the totals into averages
leftAvgActivity = leftAvgActivity/numLeft;
centerAvgActivity = centerAvgActivity/numCenter;
rightAvgActivity = rightAvgActivity/numRight;

%Find number of unique activity peaks in each location
peakList = FindPeaks(.5, activityList);
leftNumSpikes = NumUniquePeaks(peakList, leftIndexList);
centerNumSpikes = NumUniquePeaks(peakList, centerIndexList);
rightNumSpikes = NumUniquePeaks(peakList, rightIndexList);

%Calculate total time spent in each area
indexConstant = 1/sideHz;
totalTimeLeft = numLeft * indexConstant;
totalTimeCenter = numCenter * indexConstant;
totalTimeRight = numRight * indexConstant;
end