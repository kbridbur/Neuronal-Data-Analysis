function TimeStampedCoords = GetTimeStamps(SamplingFrequency, InputList, OnlyFullSeconds)
  LengthInputs = length(InputList);
  TimeStampedCoords = []; %List of timestamped inputs to be returned
  for input = 1:LengthInputs %Cycle through all the inputs and add them, with their timestamps, to the new list
    if OnlyFullSeconds
      TimeStamp = NaN;
      if mod(input, SamplingFrequency) = 0
        TimeStamp = input/SamplingFrequency;
      end
    end
    if ~OnlyFullSeconds
      TimeStamp = input/SamplingFrequency;
    end
    TimeStampedCoords = [TimeStampedCoords [TimeStamp; InputList(1, input)]]; % May need to change based on how to data is being input
  end
end