function [LeftRightData, FiberData] = GetDataFromFiles(MouseLocationFile, FiberFile)
[num, text, raw] = xlsread(MouseLocationFile, 'A:N');
matfile = strrep(FiberFile, 'tdms', 'mat')
g= simpleConvertTDMS(FiberFile);
a = num(:,[1, 13:14]);
b = rot90(a);
LeftRightData = flipud(b);
load(matfile)
FiberData = rot90(UntitledDev1ai0.Data);
end

