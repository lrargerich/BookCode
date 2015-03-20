%load mnist_classify;
load mnist_train_and_test

%% Train RBM for classification
%train rbm with 100 hidden units
m=rbmFit(mnist_train_data,100,mnist_train_labels,'verbose',true);
yhat=rbmPredict(m,mnist_test_data);

%print error
fprintf('Classification accuracy using RBM with 100 hiddens is %f%%\n', ...
    sum(yhat==mnist_test_labels)/length(yhat)*100);

%visualize weights
figure(1)
visualize(m.W);
title('learned weights');

%visualize the mislabeled cases. Note the transpose. Visualize assumes DxN
%as is the case for weights
figure(2)
visualize(mnist_train_data(yhat~=mnist_test_labels,:)');
title('classification mistakes for RBM with 100 hiddens');
drawnow;

%% Train model and denoise images
m2= rbmBB(mnist_train_data,100,'verbose',true);

%distort 100 images around by setting 95% to random noise
imgs=mnist_test_data(1:100,:);
b=rand(size(imgs))>0.95;
noised=imgs;
r=rand(size(imgs));
noised(b)=r(b);

%reconstruct the images by going up down then up again using learned model
up = rbmVtoH(m2, noised);
down= rbmHtoV(m2, up);

%figure
z1=visualize(noised');
z2=visualize(down');

figure(3)
imshow([z1 z2])
title('denoising 95% noise with RBM with 100 hidden units');
drawnow;
%% Train a DBN
op.verbose=true;
models=dbnFit(mnist_train_data,[400 400],mnist_train_labels,op,op);
yhat2=dbnPredict(models,mnist_test_data);

%print error
fprintf('Classification accuracy using DBN with 300-200-100 hiddens is %f%%\n', ...
    sum(yhat2==mnist_test_labels)/length(yhat2)*100);

%visualize weights
figure(4)
subplot(1,2,1)
visualize(models{1}.W);
title('learned weights on DBN layer 1');
subplot(1,2,2)
visualize(models{2}.W);
title('learned weights on DBN layer 2');

%visualize the mislabeled cases. Note the transpose. Visualize assumes DxN
%as is the case for weights
figure(5)
visualize(mnist_train_data(yhat2~=mnist_test_labels,:)');
title('classification mistakes for DBN with 100-100 hiddens');
