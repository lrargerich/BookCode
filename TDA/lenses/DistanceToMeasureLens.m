function res=DistanceToMeasureLens(X,k)
res=zeros(size(X,1),1);
for i=1:size(X,1)
    d=pdist2(X(i,:),X);
    [s1,s2]=sort(d);
    res(i)=mean(s1(2:(k+1)));
end
end
    
