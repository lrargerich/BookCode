SKIPTO = 5;
DISPLAY = true;

options.Method = 'lbfgs';
options.maxIter = 400;
options.display = 'on';

n = 28 * 28;
k = 10;
h1 = 200;    % Layer 1 Hidden Size
h2 = 200;    % Layer 2 Hidden Size
rho = 0.1;   
lambda = 3e-3;         % weight decay parameter
beta = 3;              % weight of sparsity penalty term

load('mnist_train_and_test.mat');
%trainLabels(trainLabels == 0) = 10; % Remap 0 to 10 since our labels need to start from 1
all_mnist=[mnist_train_data;mnist_test_data];

if SKIPTO <= 2
    fprintf('Training Autoencoder1 on the whole MNIST dataset\n');
    ae_model_1 = SparseAutoencoderTrain(all_mnist,h1,lambda,rho,beta,400);
    figure
    display_network(ae_model_1.theta_ih', 12); 
    save('step2.mat', 'ae_model_1');
else
    load('step2.mat');
end

[H1, O1] = GetActivation(ae_model_1,all_mnist);
H1=H1';

if SKIPTO <= 3
    fprintf('Training Autoencoder2 on H1\n');
    ae_model_2 = SparseAutoencoderTrain(H1,h2,lambda,rho,beta,400);
    figure
    level2_rep=ae_model_2.theta_ih*ae_model_1.theta_ih;
    display_network(level2_rep', 12); 
    save('step3.mat', 'ae_model_2');
else
    load('step3.mat')
end


if SKIPTO <= 4
    fprintf('Training Softmax classifier on H2\n');
    H1_train = GetActivation(ae_model_1,mnist_train_data);
    H1_train = H1_train';
    H1_test = GetActivation(ae_model_1,mnist_test_data);
    H1_test = H1_test';
    H2_train = GetActivation(ae_model_2,H1_train);
    H2_train = H2_train';
    H2_test = GetActivation(ae_model_2,H1_test);
    H2_test = H2_test';
    softmax_model = SoftmaxTrain(H2_train,mnist_train_labels, 10,200, 1e-4,400);
    fprintf('Predicting labels for test activation layer using learned Softmax model\n');
    pred = SoftmaxPredict(softmax_model, H2_test);

    acc1=sum(pred==mnist_test_labels)/12000;
    fprintf('Precision for Autoencoder 2 layers: %f%%\n',acc1*100);
    save('step4.mat', 'softmax_model');
else
    load('step4.mat');
end


% Initialize the stack using the parameters learned
stack = cell(2,1);
stack{1}.w = ae_model_1.theta_ih;
stack{1}.b = ae_model_1.b_ih;
stack{2}.w = ae_model_2.theta_ih;
stack{2}.b = ae_model_2.b_ih;

% Initialize the parameters for the deep model
[stackparams, netconfig] = stack2params(stack);

stacked_params = [ softmax_model.theta(:) ; stackparams ];

if SKIPTO <= 5
      model = StackedAutoencoderTrain(stacked_params,n,h2,k,netconfig,lambda,mnist_train_data,mnist_train_labels,400)
      %[stacked_params_opt, loss] = minFunc( @(x) StackedAutoencoderCost(x, ...
      %n, h2, k, netconfig, ...
      %lambda,mnist_train_data, mnist_train_labels), ...
      %stacked_params, options);
      stacked_params_opt= model.stacked_params;
      save('step5.mat', 'stacked_params_opt');
else
      load('step5.mat');
end

[pred] = StackedAutoencoderPredict(stacked_params, n, h2, ...
                          k, netconfig, mnist_test_data);

acc = mean(mnist_test_labels(:) == pred(:));
fprintf('Before Finetuning Test Accuracy: %0.3f%%\n', acc * 100);

[pred] = StackedAutoencoderPredict(stacked_params_opt, n, h2, ...
                          k, netconfig, mnist_test_data);

acc = mean(mnist_test_labels(:) == pred(:));
fprintf('After Finetuning Test Accuracy: %0.3f%%\n', acc * 100);

