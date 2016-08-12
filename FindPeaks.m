function Peaks = FindPeaks(PeakCutoff, InputList, InputHz)
  inputLength = length(InputList);
  lengthSections = round(length(InputList)*.05,0);
  if lengthSections < 30
    lengthSections = length(InputList);
  end
  numSections = ceil(inputLength/lengthSections);
  leftOver = mod(inputLength, lengthSections);
  Peaks = [];
  currentSection = 0;
  for section = 1:numSections
    if currentSection == 0 
      sectionList = InputList(1, 1:lengthSections);
    end
    if currentSection > 0
      sectionList = InputList(1, lengthSections*currentSection:lengthSections*(currentSection+1));
    end
    if currentSection == numSections
      sectionList = InputList(1, lengthSections*currentSection:lengthSections*currentSection+leftOver);
    end
    stdev = std(sectionList);
    average = avg(sectionList);
    for index = sectionList
      if index > (average+stdev*PeakCutoff)
        Peaks = [Peaks [1; index/InputHz; InputList(a)]];
      end
      if index < (average+stdev*PeakCutoff)
        Peaks = [Peaks [0; index/InputHz; NaN]];
      end
    end  
  end
end
