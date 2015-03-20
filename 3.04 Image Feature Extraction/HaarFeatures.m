function features =HaarFeatures(X,step)
if ~exist('step','var')
    step=1; 
end
features = [];
features=[features,ApplyFilter(X,@Haar1,step)];
features=[features,ApplyFilter(X,@Haar2,step)];
features=[features,ApplyFilter(X,@Haar3,step)];
features=[features,ApplyFilter(X,@Haar4,step)];
features=[features,ApplyFilter(X,@Haar5,step)];
end