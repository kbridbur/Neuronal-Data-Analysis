function peakNumber = NumUniquePeaks(peakMarkedList, indexList)
%Find the number of unique peaks in a section of an activity list
%currently not working
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

