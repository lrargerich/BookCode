addpath Softmax/
addpath Softmax/minFunc/
addpath Kmeans/

best_gamma=0;
best_acc=0;
best_features=0;
legends=cell(1,1);
lambda=0.000211;
figure
le=1;
for num_features=2000:500:2000
J=[];
legends{le}=sprintf('f=%d',num_features);
le=le+1;
%[cen,idx,dists]=Kmeans([mnist_train_data;mnist_test_data],num_features,400);
space=linspace(-0.3,2.04,20);
for i=space
    gamma=0.86;
    codes=bsxfun(@minus,gamma*mean(dists),dists);
    codes(codes<i)=0;
    kmeans_sel=sparse(codes);
   %kmeans_sel=KmeansFeatures([mnist_train_data;mnist_test_data],num_features,i); 
   model_1=SoftmaxTrain(kmeans_sel(1:48000,:),mnist_train_labels,10,num_features,lambda,400);
   [pred] = SoftmaxPredict(model_1, kmeans_sel(48001:end,:));
   acc=sum((pred==mnist_test_labels))/length(mnist_test_labels);
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
xlabel('Threshold');
ylabel('Accuracy');
title('KmeansFeatures for MNIST (gamma=0.8)');
hold on;
%plot(get(gca,'xlim'), [90.7 90.7]); % Adapts to x limits of current axes
legend(legends,'Location','SouthEast');
fprintf('Num Features: %d Best Gamma is %f accuracy %f\n',best_features,best_gamma,best_acc*100);