function TimeStampedCoords = GetTimeStamps(SamplingFrequency, InputList)
  LengthInputs = length(InputList);
  TimeStampedCoords = []; %List of timestamped inputs to be returned
  for input = 1:LengthInputs %Cycle through all the inputs and add them, with their timestamps, to the new list
    TimeStamp = input/SamplingFrequency;
    TimeStampedCoords = [TimeStampedCoords [TimeStamp; InputList(1, input)]]; % May need to change based on how to data is being input
  end
end