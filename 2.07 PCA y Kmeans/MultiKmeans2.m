function [centroids,idx,best_cost,all_costs,iter] = MultiKmeans2(X,k,iter,tol,method)
if ~exist('method','var'), method='points'; end
if ~exist('iter','var'), iter=10; end
if ~exist('tol','var'), tol=10; end
best_cost = 999999999;
lbound = ComputeKmeansBound(X,k);
centroids = [];
idx = [];
all_costs=[];
for i=1:iter
    [cen,id]=Kmeans(X,k,method);
    cost = ComputeKmeansCost(X,cen,id);   
    all_costs=[all_costs;cost];
    if cost<best_cost
        best_cost = cost;
        centroids = cen;
        idx = id;
    end
    rel = 100*(abs(cost-lbound)/cost);
    if rel<tol
        fprintf('Found good solution exiting!\n');
        break
    end
end