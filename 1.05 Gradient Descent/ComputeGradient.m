function gradient = ComputeGradient(X,y,theta)
m = size(X,1);
gradient =  (X'*((X*theta)-y)/m);
end