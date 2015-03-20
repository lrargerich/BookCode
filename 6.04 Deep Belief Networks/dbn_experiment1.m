mini_mnist_train=mnist_train_data(1:10000,:);
mini_mnist_labels=mnist_train_labels(1:10000,:);

sizes=[50,100,200,400];
layers=[1,2,3,4,5,6];

for num=sizes;
J=[];
for i=layers
    fprintf('Training %i layers with %d hidden units each\n',i,num);
    levels=repmat([num],1,i);
    models=dbnFit(mini_mnist_train,levels,mini_mnist_labels);
    yhat2=dbnPredict(models,mnist_test_data);
    acc=sum(yhat2==mnist_test_labels)/length(yhat2)*100;
    fprintf('Accuracy:%f\n',acc);
    J=[J;acc];
end
plot(layers,J);
hold on;
end
legend('50','100','200','400');
