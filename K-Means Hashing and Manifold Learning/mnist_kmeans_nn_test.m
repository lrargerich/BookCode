J=[];
y_train = cell2mat(arrayfun(@(x) [1:10]==x,mnist_train_labels,'UniformOutput',false));
y_test = cell2mat(arrayfun(@(x) [1:10]==x,mnist_test_labels,'UniformOutput',false));
for i=1000:500:1500;
   kmeans_sel=KmeansFeatures([mnist_train_data;mnist_test_data],i); 
   % Train NN for this features
   trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
   hiddenLayerSize = 500;
   net = patternnet(hiddenLayerSize);
   net.trainParam.showWindow=0;
   % Setup Division of Data for Training, Validation, Testing
   net.divideParam.trainRatio = 70/100;
   net.divideParam.valRatio = 15/100;
   net.divideParam.testRatio = 15/100;
   [net,tr] = train(net,kmeans_sel(1:48000,:)',y_train');
   y2=net(kmeans_sel(48001:end,:)');
   results1=vec2ind(y2);
   acc=sum(results1'==mnist_test_labels)/12000
   fprintf('Accuracy for %d features data:%f\n',size(kmeans_sel,2),acc*100);
   J=[J;acc*100]; 
end
plot(J)
xlabel('# of features');
ylabel('Accuracy');
title('Kmeans for MNIST');
hold on;
plot(get(gca,'xlim'), [95.1 95.1]); % Adapts to x limits of current axes
