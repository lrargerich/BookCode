% X is a matrix of m samples and 1 dimension (only one!!!)
% W is a m x 1 matrix of weights for each point
% the return is the split that has the minimum cost in missclassified
% points
% Y is a matrix of labels -1 or +1
function [best_split,best_sign]=SingleFeatureDecisionStump(X,Y,W)
m=size(X,1);
best_split=0;
best_sign=0;
cost=10e8;
best_cost=cost;

for i=1:m
    split = X(i);
    % try a split, everything <= than point is -1 all others are +1
    
    w=1;
    labels=ones(m,1);
    labels(find(X<=split))=-1;
    cost = sum((labels~=Y).*W);

    if cost<best_cost
        best_cost=cost;
        best_split=split;
        best_sign=1;
    end
    
    labels=-1*labels;
    cost = sum((labels~=Y).*W);
    if cost<best_cost
        best_cost=cost;
        best_split=split;
        best_sign=-1;
    end
end
end