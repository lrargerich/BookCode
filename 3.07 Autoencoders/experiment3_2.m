h=100;
lambda=0.0001;
rho=0.01;
%rho=0;
beta=3;
n=784;

model2 = SparseAutoencoderTrain(H_input,h,lambda,rho,beta,400)                          
figure;
display_network(model2.theta_ih', 12); 

[H2, O2] = GetActivation(model2,H_input);
figure; 
display_network(O2(:,1:100), 12);
