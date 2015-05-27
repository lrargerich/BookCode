% Add a new node to the graph joining with it's k nearest neighbors!
function [graph,X]=AddNewNode(graph,X,node,k)
  [m,n] = size(graph);
  % Get distances for this point
  X = [X;node];
  d=pdist2(node,X);
  [s1,s2]=sort(d);
  dists=s1(:,2:(k+1));
  neigs=s2(:,2:(k+1));
  for j=1:size(neigs,2)
    graph(m+1,neigs(j))=dists(j);
    graph(neigs(j),m+1)=dists(j);
  end
end