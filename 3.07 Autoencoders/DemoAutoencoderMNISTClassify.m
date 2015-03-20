n  = 28 * 28;
h = 256;
rho = 0.1; 
lambda = 3e-3;       
beta = 3;            
max_iter = 400;

fprintf('Loading MNIST train and test sets\n');
load('mnist_train_and_test.mat');

fprintf('Computing Baseline Softmax on raw data\n');
raw_softmax_model = SoftmaxTrain(mnist_train_data,mnist_train_labels, 10,784,1e-4,400);
pred = SoftmaxPredict(raw_softmax_model, mnist_test_data);
acc=sum(pred==mnist_test_labels)/12000;
fprintf('Precision for raw data Softmax: %f%%\n',acc*100);


all_mnist=[mnist_train_data;mnist_test_data];

fprintf('Training Autoencoder on the whole MNIST dataset\n');
ae_model_1 = SparseAutoencoderTrain(all_mnist,h,lambda,rho,beta,400);

figure
display_network(ae_model_1.theta_ih', 12); 

fprintf('Get activation layer for train and test sets\n');
[H_train, O] = GetActivation(ae_model_1,mnist_train_data);
[H_test, O] = GetActivation(ae_model_1,mnist_test_data);
H_train_input=H_train';
H_test_input=H_test';

fprintf('Training Softmax LR with train activation layer as input\n');
softmax_model = SoftmaxTrain(H_train_input,mnist_train_labels, 10,256, 1e-4,400);

fprintf('Predicting labels for test activation layer using learned Softmax model\n');
pred = SoftmaxPredict(softmax_model, H_test_input);

acc1=sum(pred==mnist_test_labels)/12000;
fprintf('Precision for Autoencoder 1 layer: %f%%\n',acc1*100);