sigmas=[0.05,0.10,0.25,0.5,0.75,1,1.5,2,4];
X=rand(200,2);
for i=1:length(sigmas)
   sigma=sigmas(i);
   W=CreateAffinityMatrix(X,sigma);
   subplot(3,3,i)
   imagesc(W);
   s=sprintf('Sigma=%f',sigma);
   title(s);
   colorbar;
end
colormap(hot);