imageDim = 64;         % image dimension
imageChannels = 3;     % number of channels (rgb, so 3)

patchDim = 8;          % patch dimension
numPatches = 50000;    % number of patches

visibleSize = patchDim * patchDim * imageChannels;  % number of input units 
outputSize = visibleSize;   % number of output units
hiddenSize = 400;           % number of hidden units 

epsilon = 0.1;	       % epsilon for ZCA whitening

poolDim = 19;          % dimension of pooling region

%%======================================================================
%% STEP 1: Train a sparse autoencoder (with a linear decoder) to learn 
%  features from color patches. If you have completed the linear decoder
%  execise, use the features that you have obtained from that exercise, 
%  loading them into optTheta. Recall that we have to keep around the 
%  parameters used in whitening (i.e., the ZCA whitening matrix and the
%  meanPatch)
load('STL10Features.mat');

% Display and check to see that the features look good
W = model.theta_ih;
b = model.b_ih;
figure;
displayColorNetwork( (W*ZCAWhite)');


%% STEP 2a: Implement convolution
load stlTrainSubset.mat % loads numTrainImages, trainImages, trainLabels
%% Use only the first 8 images for testing
convImages = trainImages(:, :, :, 1:8); 
% NOTE: Implement Convolve in Convolve.m first!
convolvedFeatures = Convolve(patchDim, hiddenSize, convImages, W, b, ZCAWhite, meanPatch);

%% STEP 2b: Checking your convolution
% For 1000 random points
for i = 1:1000    
    featureNum = randi([1, hiddenSize]);
    imageNum = randi([1, 8]);
    imageRow = randi([1, imageDim - patchDim + 1]);
    imageCol = randi([1, imageDim - patchDim + 1]);    
   
    patch = convImages(imageRow:imageRow + patchDim - 1, imageCol:imageCol + patchDim - 1, :, imageNum);
    patch = patch(:);            
    patch = patch - meanPatch;
    patch = ZCAWhite * patch;
    
    %features = feedForwardAutoencoder(optTheta, hiddenSize, visibleSize, patch); 
    features = GetActivation(model,patch')
    
    if abs(features(featureNum, 1) - convolvedFeatures(featureNum, imageNum, imageRow, imageCol)) > 1e-9
        fprintf('Convolved feature does not match activation from autoencoder\n');
        fprintf('Feature Number    : %d\n', featureNum);
        fprintf('Image Number      : %d\n', imageNum);
        fprintf('Image Row         : %d\n', imageRow);
        fprintf('Image Column      : %d\n', imageCol);
        fprintf('Convolved feature : %0.5f\n', convolvedFeatures(featureNum, imageNum, imageRow, imageCol));
        fprintf('Sparse AE feature : %0.5f\n', features(featureNum, 1));       
        error('Convolved feature does not match activation from autoencoder');
    end 
end

disp('Congratulations! Your convolution code passed the test.');

%% STEP 2c: Implement pooling
pooledFeatures = MeanPool(poolDim, convolvedFeatures);

%% STEP 2d: Checking your pooling
testMatrix = reshape(1:64, 8, 8);
expectedMatrix = [mean(mean(testMatrix(1:4, 1:4))) mean(mean(testMatrix(1:4, 5:8))); ...
                  mean(mean(testMatrix(5:8, 1:4))) mean(mean(testMatrix(5:8, 5:8))); ];
            
testMatrix = reshape(testMatrix, 1, 1, 8, 8);
        
pooledFeatures = squeeze(MeanPool(4, testMatrix));

if ~isequal(pooledFeatures, expectedMatrix)
    disp('Pooling incorrect');
    disp('Expected');
    disp(expectedMatrix);
    disp('Got');
    disp(pooledFeatures);
else
    disp('Congratulations! Your pooling code passed the test.');
end

%% STEP 3: Convolve and pool with the dataset
%  Because the convolved features matrix is very large, we will do the
%  convolution and pooling 50 features at a time to avoid running out of
%  memory. Reduce this number if necessary
stepSize = 50;
assert(mod(hiddenSize, stepSize) == 0, 'stepSize should divide hiddenSize');

load stlTrainSubset.mat % loads numTrainImages, trainImages, trainLabels
load stlTestSubset.mat  % loads numTestImages,  testImages,  testLabels

pooledFeaturesTrain = zeros(hiddenSize, numTrainImages, ...
    floor((imageDim - patchDim + 1) / poolDim), ...
    floor((imageDim - patchDim + 1) / poolDim) );
pooledFeaturesTest = zeros(hiddenSize, numTestImages, ...
    floor((imageDim - patchDim + 1) / poolDim), ...
    floor((imageDim - patchDim + 1) / poolDim) );

tic();

for convPart = 1:(hiddenSize / stepSize) 
    featureStart = (convPart - 1) * stepSize + 1;
    featureEnd = convPart * stepSize;
    
    fprintf('Step %d: features %d to %d\n', convPart, featureStart, featureEnd);  
    Wt = W(featureStart:featureEnd, :);
    bt = b(featureStart:featureEnd);    
    
    fprintf('Convolving and pooling train images\n');
    convolvedFeaturesThis = Convolve(patchDim, stepSize, ...
        trainImages, Wt, bt, ZCAWhite, meanPatch);
    pooledFeaturesThis = MeanPool(poolDim, convolvedFeaturesThis);
    pooledFeaturesTrain(featureStart:featureEnd, :, :, :) = pooledFeaturesThis;   
    toc();
    clear convolvedFeaturesThis pooledFeaturesThis;
    
    fprintf('Convolving and pooling test images\n');
    convolvedFeaturesThis = Convolve(patchDim, stepSize, ...
        testImages, Wt, bt, ZCAWhite, meanPatch);
    pooledFeaturesThis = MeanPool(poolDim, convolvedFeaturesThis);
    pooledFeaturesTest(featureStart:featureEnd, :, :, :) = pooledFeaturesThis;   
    toc();
    clear convolvedFeaturesThis pooledFeaturesThis;
end


% You might want to save the pooled features since convolution and pooling takes a long time
save('MeanPooledFeatures.mat', 'pooledFeaturesTrain', 'pooledFeaturesTest');
toc();

%%======================================================================
%% STEP 4: Use pooled features for classification

% Setup parameters for softmax
softmaxLambda = 1e-4;
numClasses = 4;
% Reshape the pooledFeatures to form an input vector for softmax
softmaxX = permute(pooledFeaturesTrain, [1 3 4 2]);
softmaxX = reshape(softmaxX, numel(pooledFeaturesTrain) / numTrainImages,...
    numTrainImages);
softmaxY = trainLabels;

options = struct;
options.maxIter = 200;
%softmaxModel = softmaxTrain(numel(pooledFeaturesTrain) / numTrainImages,...
%    numClasses, softmaxLambda, softmaxX, softmaxY, options);
softmaxModel = SoftmaxTrain(softmaxX',softmaxY, numClasses,numel(pooledFeaturesTrain) / numTrainImages, softmaxLambda,200);

%% STEP 5: Test classifer
%  Now you will test your trained classifer against the test images
softmaxX = permute(pooledFeaturesTest, [1 3 4 2]);
softmaxX = reshape(softmaxX, numel(pooledFeaturesTest) / numTestImages, numTestImages);
softmaxY = testLabels;

%[pred] = softmaxPredict(softmaxModel, softmaxX);
[pred] = SoftmaxPredict(softmaxModel, softmaxX');
acc = (pred(:) == softmaxY(:));
acc = sum(acc) / size(acc, 1);
fprintf('Accuracy: %2.3f%%\n', acc * 100);

% You should expect to get an accuracy of around 80% on the test images.