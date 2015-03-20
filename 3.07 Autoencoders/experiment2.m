n = 8*8;   % number of input units 
h = 25;     % number of hidden units 
rho = 0.01;   % desired average activation of the hidden units.                   
lambda = 0.0001;     % weight decay parameter       
beta = 3;            % weight of sparsity penalty term       


patches = sampleIMAGES;
display_network(patches(:,randi(size(patches,2),200,1)),8);

model = SparseAutoencoderTrain(patches',h,lambda,rho,beta,400)                          
                          

%theta_ih = reshape(opttheta(1:h*n), h, n);
display_network(model.theta_ih', 12); 

print -djpeg weights.jpg   % save the visualization to a file 


