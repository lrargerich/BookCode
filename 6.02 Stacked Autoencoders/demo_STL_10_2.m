imageDim = 64;         % image dimension
imageChannels = 3;     % number of channels (rgb, so 3)
patchDim   = 8;          % patch dimension
numPatches = 100000;   % number of patches
visibleSize = patchDim * patchDim * imageChannels;  % number of input units 
outputSize  = visibleSize;   % number of output units
poolDim = 19;          % dimension of pooling region
h  = 400;           % number of hidden units 
rho = 0.035; % desired average activation of the hidden units.
lambda = 3e-3;         % weight decay parameter       
beta = 5;              % weight of sparsity penalty term       
epsilon = 0.1;	       % epsilon for ZCA whitening

load stlSampledPatches.mat
figure;
displayColorNetwork(patches(:, 1:100));

[patches,ZCAWhite,meanPatch] = ZCAWhitening(patches',epsilon);

figure;
displayColorNetwork(patches(:, 1:100));

max_iter=400;
ae_model_1 = LinearAutoencoderTrain(patches',h,lambda,rho,beta,max_iter)
% Get the activation
[H1, O1] = GetActivation(ae_model_1,patches');
% Get the second model
ae_model_2 = SparseAutoencoderTrain(H1',h,lambda,rho,beta,400);

%% STEP 2d: Visualize learned features
figure;
displayColorNetwork( (ae_model_1.theta_ih*ZCAWhite)');



% Display and check to see that the features look good
W = ae_model_1.theta_ih;
b = ae_model_1.b_ih;


%% STEP 3: Convolve and pool with the dataset
%  Because the convolved features matrix is very large, we will do the
%  convolution and pooling 50 features at a time to avoid running out of
%  memory. Reduce this number if necessary
stepSize = 50;
hiddenSize=h;
assert(mod(hiddenSize, stepSize) == 0, 'stepSize should divide hiddenSize');


load stlTrainSubset.mat % loads numTrainImages, trainImages, trainLabels
load stlTestSubset.mat  % loads numTestImages,  testImages,  testLabels

pooledFeaturesTrain = zeros(hiddenSize, numTrainImages, ...
    floor((imageDim - patchDim + 1) / poolDim), ...
    floor((imageDim - patchDim + 1) / poolDim) );
pooledFeaturesTest = zeros(hiddenSize, numTestImages, ...
    floor((imageDim - patchDim + 1) / poolDim), ...
    floor((imageDim - patchDim + 1) / poolDim) );


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

%pft=reshape(pooledFeaturesTrain,400,2000*3*3);
%pft=ae_model_2.theta_ih*pft;
%pft=bsxfun(@plus,pft,ae_model_2.b_ih);
%pft=Sigmoid(pft);
%pooledFeaturesTrain=reshape(pft,400,2000,3,3);

%pft=reshape(pooledFeaturesTest,400,3200*3*3);
%pft=ae_model_2.theta_ih*pft;
%pft=bsxfun(@plus,pft,ae_model_2.b_ih);
%pft=Sigmoid(pft);
%pooledFeaturesTest=reshape(pft,400,3200,3,3);


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