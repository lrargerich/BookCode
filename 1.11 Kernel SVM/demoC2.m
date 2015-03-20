load('ex6data3.mat');
c_vec=[0.5,1,100,1000];
s_vec=[0.1,0.25,0.5];
for j=1:length(s_vec)
for i=1:length(c_vec)
    C=c_vec(i);
    sigma=s_vec(j);
    model= SMOSVMTrain(X, y, C, @(x1, x2) GaussianKernel(x1, x2, sigma));
    figure;
    VisualizeBoundary(X, y, model);
    s=sprintf('Sigma=%f C=%f',sigma,C);
    title(s);
end
end
fprintf('Program paused. Press enter to continue.\n');