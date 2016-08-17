function peakNumber = NumUniquePeaks(peakMarkedList, indexList)
%Find the number of unique peaks in a section of an activity list

%Consider doing this by grouping indexlists (if the list is [1,2,7,10,15]
%you can assume there are 3 peaks by looking at how close the indices are
%the peaks at 1 and 2 are most likely two parts of a single peak)
peakNumber = 0;
indices = find((peakMarkedList(1,:))==1);
areaIndices = intersect(indices, indexList);
for i = areaIndices
  if i-1 > 0
    if peakMarkedList(1,i) - peakMarkedList(1,i-1) > 0
      peakNumber = peakNumber + 1;
    end
  end
end
end

