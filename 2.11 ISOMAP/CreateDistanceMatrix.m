%% Given X a matrix of m points in n dimensions
%% creates a mxm matrix "dist" where dist_ij is the
%% distance from point "i" to point "j" only if "i"
%% is among the k-nearest neighbors of "j"
function graph = CreateDistanceMatrix(X,k)
    m = size(X,1);
    n = size(X,2);
    graph = sparse(m,m);
    for i=1:m
       [neighbors,classes,distances,indexes] = KNN(X(i,:),X,k);
       for ii = 1:length(indexes)
           graph(i,indexes(ii))=distances(ii); 
           graph(indexes(ii),i)=distances(ii); 
       end
    end
end