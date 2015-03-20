function D=BuildDistanceMatrix(X)
D=zeros(size(X,1),size(X,1));
for i=1:size(X,1)
    for j=(i+1):size(X,1)
        if (i~=j)
            D(i,j) = norm(X(i,:)-X(j,:));
            D(j,i) = D(i,j);
        end
    end
end
end