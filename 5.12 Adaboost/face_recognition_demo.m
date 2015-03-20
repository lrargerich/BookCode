% Create Haar Features for each data
data=[];
for i=1:size(faces_and_images,1)
    fprintf('Extracting Haar Features from image %d of %d\n',i,size(faces_and_images,1));
    d=HaarFeatures(reshape(faces_and_images(i,:),32,32),1);
    data=[data;d];
end

% Our next step is to train a weak classifier for each feature and combine
% them using Adaboost


