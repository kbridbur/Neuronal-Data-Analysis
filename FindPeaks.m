function Peaks = FindPeaks(PeakCutoff, InputList, EstimatedPeakLength)
  LengthInputs = length(InputList);
  StandardDev = std(InputList);
  Average = mean(InputList);
  Peaks = [];
  input = 1;
  while input < LengthInputs
    if InputList(1, input) >= (PeakCutoff*StandardDev + Average)
      lastIndex = min(input+EstimatedPeakLength, LengthInputs)
      maxPeak = max(InputList(input:lastIndex))
      for i = input:lastIndex
        if InputList(1,i) == maxPeak
          Peaks = [Peaks [1;maxPeak]];
        end
        if InputList(1,i) ~= maxPeak
          Peaks = [Peaks [0; NaN]];
        end
      end
      input = lastIndex;
    end
    if InputList(1, input) < (PeakCutoff*StandardDev + Average)
      Peaks = [Peaks [0; NaN]];    
    end
    input = input + 1;
  end
end
