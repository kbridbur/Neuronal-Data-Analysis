function Peaks = FindPeaks(PeakCutoff, InputList)
  LengthInputs = length(InputList);
  StandardDev = std(InputList);
  Average = mean(InputList);
  Peaks = [];
  for input = 0:LengthInputs
    if InputList(1, input) >= (PeakCutoff*StandardDev + Average)
      Peaks = [Peaks input];
    end
  end
end
