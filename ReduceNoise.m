function NoiseReducedCoords = ReduceNoise(ReductionLayers, WindowSize, InputList)
  ToBeAveraged = [];
  LengthInputs = length(InputList);
  NoiseReducedCoords = InputList;
  for ReductionWave = 1:ReductionLayers
    LayerReducedCoords = []; %unsure if needed, mutating NoiseReducedCoords while iterating over it would be bad though
    for input = 1:LengthInputs
      ToBeAveraged = [ToBeAveraged NoiseReducedCoords(1,input)]; %taking from noisereducedcoords allows for multiple layers of reduction
      if length(ToBeAveraged) > WindowSize
        Temp = ToBeAveraged(2:end);
        ToBeAveraged = Temp;
      end
      ReducedValue = mean(ToBeAveraged);
      LayerReducedCoords = [LayerReducedCoords ReducedValue];
    end
    NoiseReducedCoords = LayerReducedCoords;
  end
end
