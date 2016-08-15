function timeStampedCoords = GetTimeStamps(samplingFrequency, inputList, onlyFullSeconds)
  %Attaches time stamps to each data point, or exact second datapoints
  %NOTE: OnlyFullSeconds is positive to be true and negative to be false
  lengthInputs = length(inputList);
  timeStampedCoords = []; %List of timestamped inputs to be returned
  for input = 1:lengthInputs %Cycle through all the inputs and add them, with their timestamps, to the new list
    if onlyFullSeconds > 0 %If only full seconds is true then only mark points that are the closest to full seconds
      timeStamp = NaN;
      if mod(input, samplingFrequency) <= 1/samplingFrequency %in the case that two points are exactly equal to 1/SamplingFrequency this wont work
        timeStamp = floor(input/samplingFrequency);
      end
    end
    if onlyFullSeconds <= 0
      timeStamp = input/samplingFrequency;
    end
    timeStampedCoords = [timeStampedCoords [timeStamp; inputList(1, input)]]; % May need to change based on how to data is being input
  end
end