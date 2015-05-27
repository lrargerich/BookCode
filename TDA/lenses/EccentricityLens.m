function res=EccentricityLens(X)
  res=zeros(size(X,1),1);
  for i=1:size(X,1)
    if(mod(i,100)==0)
        fprintf('Processing %d points\n',i);
    end
    d=pdist2(X(i,:),X);
    res(i)=mean(d);
  end
end