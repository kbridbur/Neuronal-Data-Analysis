function noiseReducedCoords = ReduceNoise(reductionLayers, windowSize, inputList)
  %Reduces noise by simple moving average of data
  toBeAveraged = [];
  lengthInputs = length(inputList);
  noiseReducedCoords = inputList;
  for reductionWave = 1:reductionLayers
    layerReducedCoords = []; %unsure if needed, mutating NoiseReducedCoords while iterating over it would be bad though
    for input = 1:lengthInputs
      toBeAveraged = [toBeAveraged noiseReducedCoords(1,input)]; %taking from noisereducedcoords allows for multiple layers of reduction
      if length(toBeAveraged) > windowSize
        temp = toBeAveraged(2:end);
        toBeAveraged = temp;
      end
      reducedValue = mean(toBeAveraged);
      layerReducedCoords = [layerReducedCoords reducedValue];
    end
    noiseReducedCoords = layerReducedCoords;
  end
end
