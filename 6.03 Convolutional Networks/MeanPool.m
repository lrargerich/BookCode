function pooledFeatures = MeanPool(poolDim, convolvedFeatures)
%cnnPool Pools the given convolved features
%
% Parameters:
%  poolDim - dimension of pooling region
%  convolvedFeatures - convolved features to pool (as given by cnnConvolve)
%                      convolvedFeatures(featureNum, imageNum, imageRow, imageCol)
%
% Returns:
%  pooledFeatures - matrix of pooled features in the form
%                   pooledFeatures(featureNum, imageNum, poolRow, poolCol)
%

numImages = size(convolvedFeatures, 2);
numFeatures = size(convolvedFeatures, 1);
convolvedDim = size(convolvedFeatures, 3);
resultDim = floor(convolvedDim / poolDim);

pooledFeatures = zeros(numFeatures, numImages, resultDim, resultDim);

for featureNum = 1:numFeatures
  for imageNum = 1:numImages
    for poolRow = 1:resultDim
      offsetRow = 1 + (poolRow-1) * poolDim;
      for poolCol = 1:resultDim
	offsetCol = 1 + (poolCol-1) * poolDim;
	patch = convolvedFeatures(featureNum, imageNum, ...
				  offsetRow:offsetRow + poolDim-1, ...
				  offsetCol:offsetCol+poolDim-1);
	pooledFeatures(featureNum, imageNum, poolRow, poolCol) = mean(patch(:));
      end
    end
  end
end
end