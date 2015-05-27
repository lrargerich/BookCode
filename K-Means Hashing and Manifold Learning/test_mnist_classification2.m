addpath Softmax/
addpath Softmax/minFunc/
%model_0=SoftmaxTrain(mnist,labels+1,10,784,0.003,400);
%[pred] = SoftmaxPredict(model_0, mnist);
%acc=sum((pred==labels+1))/length(labels);
%fprintf('Accuracy for raw data:%f\n',acc*100);
J2=[];
ff=[];
for i=1:11
   [codes,centroids,values,kmeans_sel]=KmeansHashingDec([mnist_train_data;mnist_test_data],i);
   feature_num=size(kmeans_sel,2);
   ff=[ff;feature_num];
   model_1=SoftmaxTrain(kmeans_sel(1:48000,:),mnist_train_labels,10,size(kmeans_sel,2),0.003,400);
   [pred] = SoftmaxPredict(model_1, kmeans_sel(48001:end,:));
   acc=sum((pred==mnist_test_labels))/length(mnist_test_labels);
   fprintf('Bits: %d Features: %d Accuracy for raw data:%f\n',i,feature_num,acc*100);
   J2=[J;acc*100]; 
end
plot(ff,J2);
xlabel('# of features');
ylabel('Accuracy');
title('Binary Kmeans for MNIST');
hold on
plot(get(gca,'xlim'), [90.7 90.7]); % Adapts to x limits of current axes
