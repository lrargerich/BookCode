function [J,grad]=LogisticCostAndGradient(theta,x,y,lambda)
    J=LogisticCost(x,y,theta,lambda);
    grad=LogisticGradient(x,y,theta,lambda);
end
