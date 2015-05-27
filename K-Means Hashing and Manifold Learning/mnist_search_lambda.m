addpath Softmax/
addpath Softmax/minFunc/
num_features=100;
lambdas=linspace(0.000001,0.001,20);
best_lambda=0;
best_acc=0;
gamma=0.85;
figure
kmeans_sel=KmeansFeatures([mnist_train_data;mnist_test_data],num_features,gamma); 
J=[];
for lambda=lambdas;
model_1=SoftmaxTrain(kmeans_sel(1:48000,:),mnist_train_labels,10,num_features,lambda,400);
[pred] = SoftmaxPredict(model_1, kmeans_sel(48001:end,:));
acc=sum((pred==mnist_test_labels))/length(mnist_test_labels);
fprintf('Lambda: %f Accuracy for raw data:%f\n',lambda,acc*100);
J=[J;acc*100]; 
if acc>best_acc
       best_acc=acc;
       best_lambda=lambda;
end
end
plot(lambdas,J)
xlabel('Lambda');
ylabel('Accuracy');
title('KmeansFeatures for MNIST LR Lambda');
fprintf('Best Lambda is %f accuracy %f\n',best_lambda,best_acc);