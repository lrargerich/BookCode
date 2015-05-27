clear
load('mnist_train_and_test.mat')
num_features=4500;
gamma=0.85;
lambda=0.000211;
threshold=0.3;
%[cen,idx,dists]=Kmeans([mnist_train_data;mnist_test_data],num_features,200);
clear cen;
clear idx;
clear mnist_train_data;
clear mnist_test_data;
codes=bsxfun(@minus,gamma*mean(dists),dists);
clear dists;
codes(codes<threshold)=0;
kmeans_sel=sparse(codes);
clear codes;
model_1=SoftmaxTrain(kmeans_sel(1:48000,:),mnist_train_labels,10,num_features,lambda,900);
[pred] = SoftmaxPredict(model_1, kmeans_sel(48001:end,:));
acc=sum((pred==mnist_test_labels))/length(mnist_test_labels);
fprintf('Features: %d gamma: %f Accuracy for raw data:%f\n',num_features,gamma,acc*100);