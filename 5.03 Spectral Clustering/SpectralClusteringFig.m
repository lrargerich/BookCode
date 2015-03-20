function SpectralClusteringFig(x,v,lambdas,k)
figure
for i=1:12
   v12=v(:,1:i); 
   [cen,idx]=Kmeans(v12,k,50);
   subplot(4,3,i)
   plotDataPoints(x,idx,k);
   s=sprintf('%d Eigenvectors',i);
   title(s);
end
