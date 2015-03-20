function [centroids,idx,best_cost,all_costs] = MultiKmeans(X,k,iter,method)
if ~exist('method','var'), method='points'; end
if ~exist('iter','var'), iter=10; end
best_cost = 999999999;
centroids = [];
idx = [];
all_costs=[];
for i=1:iter
    [cen,id]=Kmeans(X,k,300,method);
    cost = ComputeKmeansCost(X,cen,id);
    all_costs=[all_costs;cost];
    if cost<best_cost
        best_cost = cost;
        centroids = cen;
        idx = id;
    end
end