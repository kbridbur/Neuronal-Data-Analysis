function peakNumber = NumUniquePeaks(PeakMarkedList, FiberHz)
%Find the number of unique peaks in a section of an activity list

%Consider doing this by grouping indexlists (if the list is [1,2,7,10,15]
%you can assume there are 3 peaks by looking at how close the indices are
%the peaks at 1 and 2 are most likely two parts of a single peak)
peakNumber = 0;
indexTimeDiff = 1/FiberHz;
indices = find(PeakMarkedList(1,:)>=1);
peakTimes = PeakMarkedList(2,indices);
for i = 1:length(peakTimes)-1
  if abs(peakTimes(1,i) - peakTimes(1,i+1)) > indexTimeDiff
    peakNumber = peakNumber + 1;
  end
end
end

