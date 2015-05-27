% clusters is a cell array of clusters
% we construct a graph with the same numbers of vertices as the number
% of clusters in the cell array
% An edge is added between clusters every time we find a point that
% belongs to both clusters.
function adj=LinkClusters(TDA)
  % Use a cell array to store the clusters where each different point
  % appears
  table=cell(TDA.points,1);
  nodes = size(TDA.clusters,2);
  adj = sparse(nodes,nodes);
  for i=1:nodes
     points=TDA.clusters{i};
     for pp=1:size(points,1)
         p=points(pp);
        links=table{p}; 
        for ll=1:size(links,1)
            l=links(ll);
            adj(i,l)=adj(i,l)+1;
            adj(l,i)=adj(l,i)+1;
        end
        table{p}=[table{p},i];
     end
  end
  u7=9;
end