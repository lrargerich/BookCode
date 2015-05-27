%% Finds the length of segments to cover the [min,max] range with n
%% overlapping segments with overlap % of overlap
%% Read that again if you want, it's clear to me!
function l=FindSegment(range,n,overlap)
l=range/((n-1)-((n-1)*overlap)+1);
end