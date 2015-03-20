imageChannels = 3;     % number of channels (rgb, so 3)

patchDim   = 8;          % patch dimension
numPatches = 100000;   % number of patches

visibleSize = patchDim * patchDim * imageChannels;  % number of input units 
outputSize  = visibleSize;   % number of output units
h  = 400;           % number of hidden units 

rho = 0.035; % desired average activation of the hidden units.
lambda = 3e-3;         % weight decay parameter       
beta = 5;              % weight of sparsity penalty term       

epsilon = 0.1;	       % epsilon for ZCA whitening

load stlSampledPatches.mat
figure;
displayColorNetwork(patches(:, 1:100));

% Subtract mean patch (hence zeroing the mean of the patches)
meanPatch = mean(patches, 2);  
patches = bsxfun(@minus, patches, meanPatch);

% Apply ZCA whitening
sigma = patches * patches' / numPatches;
[u, s, v] = svd(sigma);
ZCAWhite = u * diag(1 ./ sqrt(diag(s) + epsilon)) * u';
patches = ZCAWhite * patches;
figure;
displayColorNetwork(patches(:, 1:100));

max_iter=400;
model = LinearAutoencoderTrain(patches',h,lambda,rho,beta,max_iter)

% Save the learned features and the preprocessing matrices for use in 
% the later exercise on convolution and pooling
fprintf('Saving learned features and preprocessing matrices...\n');                          
save('STL10Features.mat', 'model', 'ZCAWhite', 'meanPatch');
fprintf('Saved\n');

%% STEP 2d: Visualize learned features
figure;
displayColorNetwork( (model.theta_ih*ZCAWhite)');
