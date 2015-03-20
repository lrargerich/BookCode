function graph = CreateLEGraph(X,k,sigma)
    m = size(X,1);
    n = size(X,2);
    graph = sparse(m,m);
    for i=1:m
       [neighbors,classes,distances,indexes] = KNN(X(i,:),X,k);
       for ii = 1:length(indexes)
           weight = exp(-1* distances(ii)/sigma);
           graph(i,indexes(ii))=weight;
           graph(indexes(ii),i)=weight;
       end
    end
end