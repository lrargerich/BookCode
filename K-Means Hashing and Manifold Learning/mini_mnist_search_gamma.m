addpath Softmax/
addpath Softmax/minFunc/
addpath Kmeans/
J=[];
best_gamma=0;
best_acc=0;
best_features=0;
vec_num_features=round(linspace(500,1000,5));
legends=cell(size(vec_num_features,2),1);
lambda=0.000211;
figure
le=1;
for num_features=vec_num_features
J=[];
legends{le}=sprintf('f=%d',num_features);
le=le+1;
[cen,idx,dists]=Kmeans([mini_train;mini_test],num_features,1000);
space=linspace(-0.3,2.24,10);
for i=space
    gamma=i;
    codes=bsxfun(@minus,gamma*mean(dists),dists);
    codes(codes<i)=0;
    kmeans_sel=sparse(codes);
    model_1=SoftmaxTrain(kmeans_sel(1:1000,:),mini_train_labels,10,num_features,lambda,400);
    [pred] = SoftmaxPredict(model_1, kmeans_sel(1001:end,:));
    acc=sum((pred==mini_test_labels))/length(mini_test_labels);
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
%plot(vec_num_features,J)
xlabel('Gamma');
ylabel('Accuracy');
title('KmeansFeatures for MNIST (gamma=0.8)');
hold on;
%plot(get(gca,'xlim'), [90.7 90.7]); % Adapts to x limits of current axes
legend(legends,'Location','SouthEast');
fprintf('Num Features: %d Best Gamma is %f accuracy %f\n',best_features,best_gamma,best_acc*100);