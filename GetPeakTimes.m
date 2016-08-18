function peakTimes = GetPeakTimes(peakMarkedData, peakHz)
%Finds indices of points labeled as peaks and returns them after
%converting to time, should later be altered to return ranges instead of
%all points
indices = find(peakMarkedData(1,:)>=1);
peakTimes = indices*1/peakHz;
end