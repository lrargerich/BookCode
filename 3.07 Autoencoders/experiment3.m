load('mnist.mat');
h=256;
lambda=0.0001;
rho=0.01;
%rho=0;
beta=3;
max_iter=100;
n=784;

model = SparseAutoencoderTrain(mnist,h,lambda,rho,beta,400)                          
figure;
display_network(model.theta_ih', 12); 

[H, O] = GetActivation(model,mnist);
H_input=H';
figure; 
display_network(O(:,1:100), 12);
