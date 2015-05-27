addpath Softmax/
addpath Softmax/minFunc/
model_0=SoftmaxTrain(mnist_train,train_labels,10,784,0.003,400);
[pred] = SoftmaxPredict(model_0, mnist_test);
acc=sum((pred==test_labels))/length(test_labels);
fprintf('Accuracy for raw data:%f\n',acc*100);
space=linspace(0.7,1.2,3);
best_gamma=0;
best_acc=0;
best_features=0;
legends=cell(1,1);
lambda=0.000211
figure
le=1;
for num_features=500:500:500
J=[];
legends{le}=sprintf('f=%d',num_features);
le=le+1;
for i=space
   kmeans_sel=KmeansFeatures([mnist_train;mnist_test],num_features,i); 
   
   model_1=SoftmaxTrain(kmeans_sel(1:60000,:),train_labels,10,num_features,lambda,400);
   [pred] = SoftmaxPredict(model_1, kmeans_sel(60001:end,:));
   acc=sum((pred==test_labels))/length(test_labels);
   fprintf('Features: %d gamma: %f Accuracy for raw data:%f\n',num_features,i,acc*100);
   J=[J;acc*100]; 
   if acc>best_acc
       best_acc=acc;
       best_gamma=i;
       best_features=num_features;
   end
end
plot(space,J)
hold on;
end
xlabel('Gamma');
ylabel('Accuracy');
title('KmeansFeatures for MNIST');
hold on;
plot(get(gca,'xlim'), [90.7 90.7]); % Adapts to x limits of current axes
legend(legends);
fprintf('Num Features: %d Best Gamma is %f accuracy %f\n',best_features,best_gamma,best_acc);