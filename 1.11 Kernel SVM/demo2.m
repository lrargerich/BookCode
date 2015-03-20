load('svmset3trainandtest.mat');

% Try different SVM Parameters here
[C, sigma] = GridSearchSVM(train, train_y, test, test_y);

load('svmset3.mat');
% Train the SVM
model= SMOSVMTrain(data, labels, C, @(x1, x2) GaussianKernel(x1, x2, sigma));
VisualizeBoundary(data, labels, model);

fprintf('Program paused. Press enter to continue.\n');