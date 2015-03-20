load mnist_classify;

%% Train RBM for classification
%train rbm with 100 hidden units
m=rbmFit(data,100,labels,'verbose',true);
yhat=rbmPredict(m,testdata);

%print error
fprintf('Classification error using RBM with 100 hiddens is %f\n', ...
    sum(yhat~=testlabels)/length(yhat));

%visualize weights
figure(1)
visualize(m.W);
title('learned weights');

%visualize the mislabeled cases. Note the transpose. Visualize assumes DxN
%as is the case for weights
figure(2)
visualize(data(yhat~=testlabels,:)');
title('classification mistakes for RBM with 100 hiddens');
drawnow;

%% Train model and denoise images
m2= rbmBB(data,100,'verbose',true);

%distort 100 images around by setting 95% to random noise
imgs=testdata(1:100,:);
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
models=dbnFit(data,[100 100],labels,op,op);
yhat2=dbnPredict(models,testdata);

%print error
fprintf('Classification error using DBN with 100-100 hiddens is %f\n', ...
    sum(yhat2~=testlabels)/length(yhat2));

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
visualize(data(yhat2~=testlabels,:)');
title('classification mistakes for DBN with 100-100 hiddens');
