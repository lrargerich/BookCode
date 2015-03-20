function KLSH=CreateKmeansLSH(X)
[m,n]=size(X);
k=floor(sqrt(m));
[centroids,idx]=Kmeans(X,k,100);
KLSH.centroids=centroids;
KLSH.idx=idx;
KLSH.X=X;
end