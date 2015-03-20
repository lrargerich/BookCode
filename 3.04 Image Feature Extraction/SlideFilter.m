% X is a mxn matrix
% filter is a f1xf2 filer (smaller than X or I'll hunt you and kill you)
% The function slides the filter accross X and returns a vector
% with all the results it could find. The number of results depends on the
% size of the X and the filter
% step controls how to slide the window, increase if the number of results
% is too big.
function [results,newimg]=SlideFilter(X,filter,step)
if ~exist('step','var')
    step=1; 
end
[x,y]=size(X);
[fx,fy]=size(filter);
results=[];

max_x = x-fx+1;
max_y = y-fy+1;
newimg=zeros(x,y);

for x=1:step:max_x
    for y=1:step:max_y
        crop = X(x:(x+fx-1),y:(y+fy-1));
        aux = sum(sum(crop.*filter));
        filter_mask=filter>0;
        window=crop.*filter;
        window=window.*filter_mask;
        window=filter_mask.*aux;
        results = [results,aux];
        newimg(x:(x+fx-1),y:(y+fy-1))=newimg(x:(x+fx-1),y:(y+fy-1))+window;
    end
end
end