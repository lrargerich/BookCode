function alpha=LineSearch(X,y,theta,gradient)
cost1=0;
cost2=999;
alpha=8;
m=size(X,1);
while(cost2>cost1)
    alpha=alpha/2;
    cost1=ComputeCost(X,y,theta);
    thetax = theta - alpha * gradient;
    cost2=ComputeCost(X,y,thetax);
end
end