numPatches=500000;
imageDim = 32;         % image dimension
imageChannels = 3;     % number of channels (rgb, so 3)
patchDim = 9;          % patch dimension
visibleSize = patchDim * patchDim * imageChannels;  % number of input units 
outputSize = visibleSize;   % number of output units
hiddenSize = 400;           % number of hidden units 
epsilon = 0.1;	       % epsilon for ZCA whitening
poolDim = 8;          % dimension of pooling region

load('cifar-10-color.mat')
figure;
ShowColorImagesInGrid(imgs,8)
patches=CropColorPatchesFromImages(imgs,patchDim,numPatches);
patches=double(patches);
patches=patches/255;
% Show patches 
figure;
displayColorNetwork(patches(1:100,:)');


% Perform ZCA Whitening
patches=patches';
% Subtract mean patch (hence zeroing the mean of the patches)
meanPatch = mean(patches, 2);  
patches = bsxfun(@minus, patches, meanPatch);

% Apply ZCA whitening
sigma = patches * patches' / numPatches;
[u, s, v] = svd(sigma);
ZCAWhite = u * diag(1 ./ sqrt(diag(s) + epsilon)) * u';
patches = ZCAWhite * patches;
patches=patches';

% Show WhitenedPatches
figure;
displayColorNetwork(patches(1:100,:)');


% Save whitened patches
save('patches_whitened','patches');
% Run linear autoencoder for level 1 features
h=400;
rho=0.035;
lambda=3e-3;
beta=5;
max_iter=400;
model = LinearAutoencoderTrain(patches,h,lambda,rho,beta,max_iter)
% Show features
figure;
displayColorNetwork( (model.theta_ih*ZCAWhite)');
% Save features and model and whitendata and so on
save('model_ae_cifar_patches','model');

% For every image convolve (this is difficult!)
