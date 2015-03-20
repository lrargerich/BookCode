function [U,S]=MDS2(D)

D2 = D.^2;
rowMeans = mean(D2,2);
colMeans = mean(D2,1);
totalMean = mean(rowMeans);

for i = 1:size(D2,1)
  for j=1:size(D2,1)
    D2(i,j) = D2(i,j) + totalMean - rowMeans(i) - colMeans(j);
  end
end

[U,S,V]=svd(D2);

end