function Peaks = FindPeaks(PeakCutoff, InputList)
  %Divides inputs into smaller sections and marks peaks based on the avg
  %and std dev of that section. This is to avoid inaccurate marking in the
  %case that the data has a general trend throughout
  inputLength = length(InputList);
  lengthSections = round(length(InputList)*.04);
  if lengthSections < 30
    lengthSections = length(InputList);
  end
  numSections = floor(inputLength/lengthSections);
  leftOver = mod(inputLength, lengthSections);
  Peaks = [];
  currentSection = 0;
  for section = 1:numSections
    if currentSection == 0 
      sectionList = InputList(1, 1:lengthSections);
    end
    if currentSection > numSections-1
      sectionList = InputList(1, lengthSections*currentSection:lengthSections*(currentSection)+leftOver);
    end
    if currentSection > 0 && currentSection <= numSections-1
      sectionList = InputList(1, lengthSections*currentSection:lengthSections*(currentSection+1));
    end
    stdev = std(sectionList);
    average = mean(sectionList);
    for index = 1:length(sectionList)
      if sectionList(index) > (average+stdev*PeakCutoff)
        Peaks = [Peaks [1; sectionList(index)]];
      end
      if sectionList(index) < (average+stdev*PeakCutoff)
        Peaks = [Peaks [0; NaN]];
      end
    end
    currentSection = currentSection + 1;
  end
end
