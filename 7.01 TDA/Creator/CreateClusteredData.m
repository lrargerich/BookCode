function x=CreateClusteredData(clusters,dims,points_per_cluster)
x=[];

for i=1:clusters
    cluster=rand(floor((1+rand())*points_per_cluster),dims);
    cluster=(cluster*rand()*2)-0.5;
    randomdir=round(rand(1,dims)*10-4);
    cluster=bsxfun(@plus,cluster,randomdir);
    x=[x;cluster];
end
x=featureNormalize(x);
x=[x;rand(round(points_per_cluster*clusters*0.05)+1,dims)];
end
