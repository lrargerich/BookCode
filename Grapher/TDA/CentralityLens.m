% for each n-dimensional data point computes the max distance to any other
% point
function res=CentralityLens(X)
  res=zeros(size(X,1),1);
  for i=1:size(X,1)
    if(mod(i,100)==0)
        fprintf('Processing %d points\n',i);
    end
    d=pdist2(X(i,:),X);
    res(i)=max(d);
  end
end