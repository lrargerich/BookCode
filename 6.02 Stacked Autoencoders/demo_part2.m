% Display and check to see that the features look good
W = model.theta_ih;
b = model.b_ih;

%% STEP 3: Convolve and pool with the dataset
%  Because the convolved features matrix is very large, we will do the
%  convolution and pooling 50 features at a time to avoid running out of
%  memory. Reduce this number if necessary
stepSize = 20;
assert(mod(hiddenSize, stepSize) == 0, 'stepSize should divide hiddenSize');

% CONVERT TRAIN IMAGES INTO SOMETHING LIKE
load('cifar-10-color.mat')
imgs=double(imgs)/255;
imgs=reshape(imgs,50000,32,32,3);
imgs=permute(imgs,[2 3 4 1]);
test_imgs=double(test_imgs)/255;
test_imgs=reshape(test_imgs,10000,32,32,3);
test_imgs=permute(test_imgs,[2 3 4 1]);
% LIKE 64x64x3x2000
% PULL ALL PATCHES FROM TEST IMAGES
trainImages=imgs;
trainLabels=labels;
testImages=test_imgs;
testLabels=test_labels;
numTrainImages=50000;
numTestImages=10000;

% Clear Stuff we don't really need anymore
clear patches;
clear imgs;
clear test_imgs;
clear u;
clear v;
clear s;
clear sigma;


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
numClasses = 10;
% Reshape the pooledFeatures to form an input vector for softmax
softmaxX = permute(pooledFeaturesTrain, [1 3 4 2]);
softmaxX = reshape(softmaxX, numel(pooledFeaturesTrain) / numTrainImages,...
    numTrainImages);
softmaxY = double(trainLabels)+1;

options = struct;
options.maxIter = 200;
%softmaxModel = softmaxTrain(numel(pooledFeaturesTrain) / numTrainImages,...
%    numClasses, softmaxLambda, softmaxX, softmaxY, options);
softmaxModel = SoftmaxTrain(softmaxX',softmaxY, numClasses,numel(pooledFeaturesTrain) / numTrainImages, softmaxLambda,1000);

%% STEP 5: Test classifer
%  Now you will test your trained classifer against the test images
softmaxX = permute(pooledFeaturesTest, [1 3 4 2]);
softmaxX = reshape(softmaxX, numel(pooledFeaturesTest) / numTestImages, numTestImages);
softmaxY = double(testLabels)+1;

%[pred] = softmaxPredict(softmaxModel, softmaxX);
[pred] = SoftmaxPredict(softmaxModel, softmaxX');
acc = (pred(:) == softmaxY(:));
acc = sum(acc) / size(acc, 1);
fprintf('Accuracy: %2.3f%%\n', acc * 100);

% You should expect to get an accuracy of around 80% on the test images.