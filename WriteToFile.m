function [] = WriteToFile(timeStampedList, timeList, activityMatrix)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
correctedTimes = timeStampedList(2,:)*.01;
realTimeStampList = [timeStampedList(1,:);correctedTimes];
d = date;
rotatedTimeList = rot90(timeList, 3);
rotatedTimeStampList = rot90(realTimeStampList, 3);
xlswrite([d, '-datafile.xlsx'], rotatedTimeStampList);
xlswrite([d, '-datafile.xlsx'], rotatedTimeList, 'Peak Times')
xlswrite([d, '-datafile.xlsx'], activityMatrix, 'Statistics')
end

