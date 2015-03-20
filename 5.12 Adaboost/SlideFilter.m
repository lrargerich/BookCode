% X is a mxn matrix
% filter is a f1xf2 filer (smaller than X or I'll hunt you and kill you)
% The function slides the filter accross X and returns a vector
% with all the results it could find. The number of results depends on the
% size of the X and the filter
% step controls how to slide the window, increase if the number of results
% is too big.
function results=SlideFilter(X,filter,step)
if ~exist('step','var')
    step=1; 
end
[x,y]=size(X);
[fx,fy]=size(filter);
results=[];

max_x = x-fx+1;
max_y = y-fy+1;

for x=1:step:max_x
    for y=1:step:max_y
        crop = X(x:(x+fx-1),y:(y+fy-1));
        aux = sum(sum(crop.*filter));
        results = [results,aux];
    end
end
end