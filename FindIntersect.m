function [intersect] = FindIntersect(a, b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
intersect = [];
aIndex = 1;
bIndex = 1;
while bIndex < length(b)
  if aIndex > length(a)
    return 
  end
  if b(1, bIndex) == a(1,aIndex)
    intersect = [intersect a(1,aIndex)];
    aIndex = aIndex + 1;
    bIndex = bIndex + 1;
  elseif b(1, bIndex) > a(1,aIndex)
    aIndex = aIndex + 1;
  elseif b(1, bIndex) < a(1,aIndex)
    bIndex = bIndex + 1;
  end
end  
end

