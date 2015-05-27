addpath Softmax/
addpath Softmax/minFunc/
%J=[];
model_0=SoftmaxTrain(mnist_train_data,mnist_train_labels,10,784,0.003,400);
[pred] = SoftmaxPredict(model_0, mnist_test_data);
acc=sum((pred==mnist_test_labels))/length(mnist_test_labels);
fprintf('Accuracy for raw data:%f\n',acc*100);
for i=2500:500:4000
   kmeans_sel=KmeansFeatures([mnist_train_data;mnist_test_data],i); 
   model_1=SoftmaxTrain(kmeans_sel(1:48000,:),mnist_train_labels,10,i,0.003,400);
   [pred] = SoftmaxPredict(model_1, kmeans_sel(48001:end,:));
   acc=sum((pred==mnist_test_labels))/length(mnist_test_labels);
   fprintf('Features: %d Accuracy for raw data:%f\n',i,acc*100);
   J=[J;acc*100]; 
end
plot(J)
xlabel('# of features');
ylabel('Accuracy');
title('Kmeans for MNIST');
hold on;
plot(get(gca,'xlim'), [90.7 90.7]); % Adapts to x limits of current axes
