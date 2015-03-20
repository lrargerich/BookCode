load('ex6data3.mat');

% Try different SVM Parameters here
[C, sigma] = GridSearchSVM(X, y, Xval, yval);

% Train the SVM
model= SMOSVMTrain(X, y, C, @(x1, x2) GaussianKernel(x1, x2, sigma));
VisualizeBoundary(X, y, model);

fprintf('Program paused. Press enter to continue.\n');


