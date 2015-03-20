function results=AdaPredict(X,C,alpha)
  results=zeros(size(X,1),1);
  for i=1:size(alpha,2)
      vec=C{i};
      results = results+alpha(i)*StumpPredict(X,vec(1),vec(2),vec(3))
  end
  results=results>0;
  results=results*2-1;
end