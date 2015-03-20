%% Try to improve K-Means by splitting two clusters randomly using a good method
function [cen,idx,cost] = KmeansImprover(X,cen,idx,k,iter)
cost = ComputeKmeansCost(X,cen,idx);
lbound = ComputeKmeansBound(X,k);
rel = 100*(abs(cost-lbound)/cost);
fprintf('We begin with cost=%f and lower bound=%f (%f)\n',cost,lbound,rel);
for i=1:iter
    r1 = floor(1+(rand()*k));
    r2 = floor(1+(rand()*k));
    while r1==r2
        r1 = floor(1+(rand()*k));
        r2 = floor(1+(rand()*k));
    end
    % Take this subset
    subx = X(idx==r1 | idx==r2,:);
    % Cluster in two sets
    idxe=EigenCluster2(subx);
    idxe(idxe==1) = r1;
    idxe(idxe==2) = r2;
    idx2=idx;
    idx2(idx==r1 | idx==r2) = idxe;
    cen2 = computeCentroids(X, idx2, k);
    new_cost = ComputeKmeansCost(X,cen2,idx2);
    if new_cost < cost 
        cost = new_cost;
        cen = cen2;
        idx = idx2;
        rel = 100*(abs(cost-lbound)/cost);
        fprintf('IMPROVED! cost=%f and lower bound=%f (%f)\n',cost,lbound,rel);
    end
end
end