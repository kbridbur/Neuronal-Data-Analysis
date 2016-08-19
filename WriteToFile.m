function [] = WriteToFile(timeStampedList, timeList, activityMatrix)
%Converts information into a better readable format and writes it to an
%xlsx file
correctedTimes = timeStampedList(2,:)*.01;
realTimeStampList = [timeStampedList(1,:);correctedTimes];
d = date;
c = clock;
b = fix(c);
stringTime = ['-', int2str(b(5)), int2str(b(4)), int2str(b(6))];
rotatedTimeList = rot90(timeList, 3);
rotatedTimeStampList = rot90(realTimeStampList, 3);
xlswrite([d, stringTime, '-datafile.xlsx'], rotatedTimeStampList);
xlswrite([d, stringTime, '-datafile.xlsx'], rotatedTimeList, 'Peak Times')
xlswrite([d, stringTime, '-datafile.xlsx'], activityMatrix, 'Statistics')
end

