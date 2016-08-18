function [leftRightData, fiberData] = GetDataFromFiles(mouseLocationFile, fiberFile)
%pulls data from files and formats it
if nargin < 2
  %Prompt the user for the file
  [filename,pathname]=uigetfile({'*.tdms','All Files (*.tdms)'},'Choose a TDMS File');
  fiberFile=fullfile(pathname,filename);
end
if nargin < 1  
  %Prompt the user for the file
  [filename,pathname]=uigetfile({'*.xlsx','All Files (*.xlsx)'},'Choose a xlsx File');
  mouseLocationFile=fullfile(pathname,filename);
end
[num, text, raw] = xlsread(mouseLocationFile, 'A:N');
matfile = strrep(fiberFile, 'tdms', 'mat')
g= simpleConvertTDMS(fiberFile);
a = num(:,[1, 13:14]);
b = rot90(a);
leftRightData = flipud(b);
load(matfile)
fiberData = rot90(UntitledDev1ai0.Data);
end

