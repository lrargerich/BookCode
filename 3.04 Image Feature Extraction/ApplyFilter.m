% X is a x x y matrix
% filter is a fx x fy filter
% This function will apply all size variants of a filter
% to X. It will return many results!
function results=ApplyFilter(X,filter,step)
if ~exist('step','var')
    step=1; 
end

ratio = 1;

[x,y]=size(X);
f = filter(ratio);
[fx,fy]=size(f);
results =[];

while (fx<=x && fy<=y)
    results = [results,SlideFilter(X,f,step)];
    ratio=ratio+1;
    f = filter(ratio);
    [fx,fy]=size(f);
end
end