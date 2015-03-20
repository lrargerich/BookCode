load('svmset3.mat');
% Train the SVM
c_vec=[0.05,0.5,1,10,100];
s_vec=[0.01,0.03,0.5,1];
for j=1:length(s_vec)
for i=1:length(c_vec)
    C=c_vec(i);
    sigma=s_vec(j);
    model= SMOSVMTrain(data, labels, C, @(x1, x2) GaussianKernel(x1, x2, sigma));
    figure;
    VisualizeBoundary(data, labels, model);
    s=sprintf('Sigma=%f C=%f',sigma,C);
    title(s);
end
end
fprintf('Program paused. Press enter to continue.\n');