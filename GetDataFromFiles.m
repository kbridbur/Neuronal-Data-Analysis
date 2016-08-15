function [LeftRightData, FiberData] = GetDataFromFiles(MouseLocationFile, FiberFile)
if nargin < 2
  %Prompt the user for the file
  [filename,pathname]=uigetfile({'*.tdms','All Files (*.tdms)'},'Choose a TDMS File');
  FiberFile=fullfile(pathname,filename);
end
if nargin < 1  
  %Prompt the user for the file
  [filename,pathname]=uigetfile({'*.xlsx','All Files (*.xlsx)'},'Choose a xlsx File');
  MouseLocationFile=fullfile(pathname,filename);
end
[num, text, raw] = xlsread(MouseLocationFile, 'A:N');
matfile = strrep(FiberFile, 'tdms', 'mat')
g= simpleConvertTDMS(FiberFile);
a = num(:,[1, 13:14]);
b = rot90(a);
LeftRightData = flipud(b);
load(matfile)
FiberData = rot90(UntitledDev1ai0.Data);
end

