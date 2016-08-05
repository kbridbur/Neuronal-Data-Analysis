function peakNumber = NumUniquePeaks(IndexList, PeakMarkedList)
%Find the number of unique peaks in a section of an activity list
peakNumber = 0;
for i = 1:Length(IndexList)
  if PeakMarkedList(1,IndexList(1, i)) = 1 & PeakMarkedList(1, IndexList(1, i)-1) = 0
    peakNumber = peakNumber + 1;
  end
end
end

