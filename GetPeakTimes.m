function peakTimes = GetPeakTimes(peakMarkedData, peakHz)
%Finds indices of points labeled as peaks and returns them after
%converting to time, returns center times of each peak
peakTimes = [];
indices = find(peakMarkedData(1,:)>=1);
roughPeakTimes = indices*1/peakHz
startPeak = roughPeakTimes(1,1);
lastI= startPeak;
diff = 1/peakHz;
for i = roughPeakTimes
  if abs(i - lastI) > diff*15
    peakTimes = [peakTimes (startPeak+lastI)/2];
    startPeak = i;
  end
  lastI = i;
end
peakTimes = [peakTimes (startPeak+lastI)/2];
end