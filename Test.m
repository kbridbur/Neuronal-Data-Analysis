%[num, text, raw] = xlsread('C:\Users\Kyle Bridburg\Downloads\test.xlsx', 'A:N');
%a = num(:,[1, 13:14]);
%b = rot90(a);
%LeftRightData = flipud(b)
[a, b] = GetDataFromFiles('ExampleRawData.xlsx', 'ExampleFiberPhotomertyData.tdms')
RelateSideToNeuronActivity(b, 100, a, 10)