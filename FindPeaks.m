function Peaks = FindPeaks(PeakCutoff, InputList, EstimatedPeakLength, InputHz)
  LengthInputs = length(InputList);
  StandardDev = std(InputList);
  Average = mean(InputList);
  Peaks = [];
  a = 1;
  while a < LengthInputs
    if InputList(1, a) >= (PeakCutoff*StandardDev + Average)
      lastIndex = min(a+EstimatedPeakLength, LengthInputs);
      maxPeak = max(InputList(a:lastIndex));
      for b = a:lastIndex
        if InputList(1,b) == maxPeak
          Peaks = [Peaks [1; b/InputHz; maxPeak]];
        end
        if InputList(1,b) ~= maxPeak
          Peaks = [Peaks [0; b/InputHz; NaN]];
        end
      end
      a = lastIndex;
    end
    if InputList(1, a) < (PeakCutoff*StandardDev + Average)
      Peaks = [Peaks [0; a/InputHz; NaN]];    
    end
    a = a + 1;
  end
end
