addpath Softmax/
addpath Softmax/minFunc/
num_features=500;
gammaspace=linspace(0.001,0.015,10);
tspace=linspace(0,0.04,10);
best_gamma=0;
best_threshold=0;
best_acc=0;
lambda=0.000211;
le=1;
J=[];
figure
legends=cell(size(gammaspace,1),1);
ll=1;
%[cen,idx,dists]=Kmeans([mnist_train_data;mnist_test_data],num_features,100);
for gamma=gammaspace
legends{ll}=sprintf('gamma=%f',gamma);
ll=ll+1;
J=[];
for t=tspace
   %kmeans_sel=KmeansFeaturesRBF([mnist_train_data;mnist_test_data],num_features,gamma,t);  
   codes=exp(-gamma*dists);
   codes(codes<t)=0;
   kmeans_sel=sparse(codes);
   model_1=SoftmaxTrain(kmeans_sel(1:48000,:),mnist_train_labels,10,num_features,lambda,400);
   [pred] = SoftmaxPredict(model_1, kmeans_sel(48001:end,:));
   acc=sum((pred==mnist_test_labels))/length(mnist_test_labels);
   J=[J;acc];
   fprintf('Gamma: %f threshold: %f Accuracy for raw data:%f\n',gamma,t,acc*100);
   if acc>best_acc
       best_acc=acc;
       best_gamma=gamma;
       best_threshold=t;
   end
end
plot(tspace,J);
hold on;
end
legend(legends);
xlabel('threshold');
ylabel('accuracy');
title('MNIST Kmeans with RBF features');
fprintf('Best Gamma is %f Best threshold is %f accuracy %f\n',best_gamma,best_threshold,best_acc);