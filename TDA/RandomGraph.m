function graph=RandomGraph(nodes,edges)
graph=sparse(nodes,nodes);
edges_count=0;
while edges_count<edges
    per = randperm(nodes);
    n1 = per(1);
    n2 = per(2);
    graph(n1,n2)=1;
    edges_count=nnz(graph);
end