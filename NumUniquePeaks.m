function peakNumber = NumUniquePeaks(IndexList, PeakMarkedList)
%Find the number of unique peaks in a section of an activity list

%Consider doing this by grouping indexlists (if the list is [1,2,7,10,15]
%you can assume there are 3 peaks by looking at how close the indices are
%the peaks at 1 and 2 are most likely two parts of a single peak)
peakNumber = 0;
for i = 1:Length(IndexList)
  if PeakMarkedList(1,IndexList(1, i)) = 1 & PeakMarkedList(1, IndexList(1, i)-1) = 0
    peakNumber = peakNumber + 1;
  end
end
end

