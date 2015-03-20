function [results,newimg]=SobelFilter(X,step)
if ~exist('step','var')
    step=1; 
end
filter1=[-1 0 1;-2 0 2;-1 0 1];
filter2=[-1 -2 -1;0 0 0;1 2 1];
[r1,n1]=SlideFilter(X,filter1,step);
[r2,n2]=SlideFilter(X,filter2,step);
results=[r1,r2];
newimg=sqrt(n1.^2+n2.^2);
end