function peakTimes = GetPeakTimes(peakMarkedData)
indices = find(peakMarkedData(1,:)>=1);
peakTimes = peakMarkedData(2,indices);
end

