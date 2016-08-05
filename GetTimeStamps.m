function TimeStampedCoords = GetTimeStamps(SamplingFrequency, InputList, OnlyFullSeconds)
  %Attaches time stamps to each data point, or exact second datapoints
  %NOTE: OnlyFullSeconds is positive to be true and negative to be false
  LengthInputs = length(InputList);
  TimeStampedCoords = []; %List of timestamped inputs to be returned
  for input = 1:LengthInputs %Cycle through all the inputs and add them, with their timestamps, to the new list
    if OnlyFullSeconds > 0 %If only full seconds is true then only mark points that are the closest to full seconds
      TimeStamp = NaN;
      if mod(input, SamplingFrequency) <= 1/SamplingFrequency %in the case that two points are exactly equal to 1/SamplingFrequency this wont work
        TimeStamp = input/SamplingFrequency - mod(input/SamplingFrequency, 1);
      end
    end
    if OnlyFullSeconds <= 0
      TimeStamp = input/SamplingFrequency;
    end
    TimeStampedCoords = [TimeStampedCoords [TimeStamp; InputList(1, input)]]; % May need to change based on how to data is being input
  end
end