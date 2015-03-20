function convolvedFeatures = Convolve(patch_size, num_features, images, W, b, ZCAWhite, patch_mean)
%cnnConvolve Returns the convolution of the features given by W and b with
%the given images
%
% Parameters:
%  patch_size - patch (feature) dimension
%  num_features - number of features
%  images - large images to convolve with, matrix in the form
%           images(r, c, channel, image number)
%  W, b - W, b for features from the sparse autoencoder
%  ZCAWhite, meanPatch - ZCAWhitening and meanPatch matrices used for
%                        preprocessing
%
% Returns:
%  convolvedFeatures - matrix of convolved features in the form
%                      convolvedFeatures(featureNum, imageNum, imageRow, imageCol)

patch_total_size = patch_size * patch_size;
num_images = size(images, 4);
image_dim = size(images, 1);
image_channels = size(images, 3);

assert(num_features == size(W, 1), 'W should have numFeatures rows');
assert(patch_total_size*image_channels == size(W, 2), 'W should have patchDim^2*imageChannels columns');

convolvedFeatures = zeros(num_features, num_images, image_dim - patch_size + 1, image_dim - patch_size + 1);

WT = W * ZCAWhite;
b_w = b - WT * patch_mean;

features = zeros(image_channels, num_features, patch_total_size);
for channel = 1:image_channels
  offset = patch_total_size * (channel-1);
  features(channel, :, :) = WT(:, offset+1:offset+patch_total_size);
end

convolvedFeatures = zeros(num_features, num_images, image_dim - patch_size + 1, image_dim - patch_size + 1);
for imageNum = 1:num_images
  for featureNum = 1:num_features
    % convolution of image with feature matrix for each channel
    convolvedImage = zeros(image_dim - patch_size + 1, image_dim - patch_size + 1);
    sumfp = 0;
    for channel = 1:image_channels
      % Obtain the feature (patchDim x patchDim) needed during the convolution
      offset = patch_total_size * (channel-1);
      feature = reshape(WT(featureNum, offset+1:offset+patch_total_size), patch_size, patch_size);
      % Flip the feature matrix because of the definition of convolution, as explained later
      feature = flipud(fliplr(squeeze(feature)));
      % Obtain the image
      im = squeeze(images(:, :, channel, imageNum));
      % Convolve "feature" with "im", adding the result to convolvedImage
      % be sure to do a 'valid' convolution
      convolved = conv2(im, feature, 'valid');
      convolvedImage = convolvedImage + convolved;
    end
    % Subtract the bias unit (correcting for the mean subtraction as well)
    % Then, apply the sigmoid function to get the hidden activation
    convolvedImage = Sigmoid(convolvedImage + b_w(featureNum));
    % The convolved feature is the sum of the convolved values for all channels
    convolvedFeatures(featureNum, imageNum, :, :) = convolvedImage;
  end
end
end