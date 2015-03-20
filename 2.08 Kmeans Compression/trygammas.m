gammas=[0.01,0.15,0.2,0.5,1,2,4];
for i=1:length(gammas)
   gamma=gammas(i);
   r1=KmeansGammaReducer(images,cen,gamma);
   str = sprintf('Gamma = %f',gamma);
   subplot(2,3,i),plotDataPoints(r1,labels+1,10);title(str);
end