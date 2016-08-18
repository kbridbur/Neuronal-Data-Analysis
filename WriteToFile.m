function [] = WriteToFile(timeStampedList, timeList, activityMatrix)
%Converts information into a better readable format and writes it to an
%xlsx file
correctedTimes = timeStampedList(2,:)*.01;
realTimeStampList = [timeStampedList(1,:);correctedTimes];
d = date;
rotatedTimeList = rot90(timeList, 3);
rotatedTimeStampList = rot90(realTimeStampList, 3);
xlswrite([d, '-datafile.xlsx'], rotatedTimeStampList);
xlswrite([d, '-datafile.xlsx'], rotatedTimeList, 'Peak Times')
xlswrite([d, '-datafile.xlsx'], activityMatrix, 'Statistics')
end

