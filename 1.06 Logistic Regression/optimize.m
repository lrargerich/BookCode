load('lrset3.mat');
datapoly=MapToPoly(data,6);
datapoly2=[ones(size(datapoly,1),1),datapoly]; 
initial_theta = zeros(28,1);
options = optimset('GradObj', 'on', 'MaxIter', 5000);
lambda=0.5;
[theta] = fmincg (@(t)(LogisticCostAndGradient(t, datapoly2, labels, lambda)), initial_theta, options);
VisualizeBoundary(theta,datapoly,labels,6);