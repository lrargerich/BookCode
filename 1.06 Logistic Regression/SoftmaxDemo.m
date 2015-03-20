n = 28 * 28; 
k = 10;     
lambda = 1e-4; 
load('mnist.mat');
X = mnist;
labels(labels==0) = 10; % Remap 0 to 10
max_iter=400;
model = SoftmaxTrain(X,labels,k, n, lambda, max_iter);
[pred] = SoftmaxPredict(model, X);
acc = mean(labels(:) == pred(:));
fprintf('Accuracy: %0.3f%%\n', acc * 100);


