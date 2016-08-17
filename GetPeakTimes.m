function peakTimes = GetPeakTimes(peakMarkedData, peakHz, startTime)
indices = find(peakMarkedData(1,:)>=1);
peakTimes = indices*1/peakHz
end