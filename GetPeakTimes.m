function [PeakTimes] = GetPeakTimes(PeakMarkedData)
indices = find(PeakMarkedData(1,:)>=1)
PeakTimes = PeakMarkedData(2,indices);
end

