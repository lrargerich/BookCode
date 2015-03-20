models=dbnFit(mini_mnist_train,[100 200 400 200 100],mini_mnist_labels);
yhat2=dbnPredict(models,mnist_test_data);
acc=sum(yhat2==mnist_test_labels)/length(yhat2)*100;
fprintf('100 200 400 200 100 Accuracy:%f\n',acc);

models=dbnFit(mini_mnist_train,[300 400 300],mini_mnist_labels);
yhat2=dbnPredict(models,mnist_test_data);
acc=sum(yhat2==mnist_test_labels)/length(yhat2)*100;
fprintf('300 400 300 Accuracy:%f\n',acc);

models=dbnFit(mini_mnist_train,[100 400 100],mini_mnist_labels);
yhat2=dbnPredict(models,mnist_test_data);
acc=sum(yhat2==mnist_test_labels)/length(yhat2)*100;
fprintf('100 400 100 Accuracy:%f\n',acc);

models=dbnFit(mini_mnist_train,[200 200 400 200 200],mini_mnist_labels);
yhat2=dbnPredict(models,mnist_test_data);
acc=sum(yhat2==mnist_test_labels)/length(yhat2)*100;
fprintf('200 200 400 200 200 Accuracy:%f\n',acc);

models=dbnFit(mini_mnist_train,[200 400 400 200],mini_mnist_labels);
yhat2=dbnPredict(models,mnist_test_data);
acc=sum(yhat2==mnist_test_labels)/length(yhat2)*100;
fprintf('200 400 400 200 Accuracy:%f\n',acc);
