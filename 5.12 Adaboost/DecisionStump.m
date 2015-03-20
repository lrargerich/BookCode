% Multi Feature Decision Stump
% Finds the best split and the dimension to split
function [best_split,best_sign,best_dim]=DecisionStump(X,Y,W)
[m,n]=size(X);
best_split=0;
best_sign=0;
cost=10e8;
best_cost=cost;
best_dim=1;
for j=1:n
    
    for i=1:m
        split = X(i,j);
        % try a split, everything <= than point is -1 all others are +1
        w=1;
        labels=ones(m,1);
        labels(find(X(:,j)<=split))=-1;
        cost = sum((labels~=Y).*W);

        if cost<best_cost
            best_cost=cost;
            best_split=split;
            best_sign=1;
            best_dim=j;
        end

        labels=-1*labels;
        cost = sum((labels~=Y).*W);
        if cost<best_cost
            best_cost=cost;
            best_split=split;
            best_sign=-1;
            best_dim=j;
        end
    end
end
end