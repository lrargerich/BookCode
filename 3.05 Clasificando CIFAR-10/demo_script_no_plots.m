clear
% Load all dataset
load('all_data.mat')

labels = double(labels);
labels2 = labels+1;
test_labels = double(test_labels);
test_labels2 = test_labels+1;

% Convert to Grayscale
gimgs=CIFARtoGrayscale(imgs);
gtest=CIFARtoGrayscale(test_imgs);

% Transpose the images
gimgs=TransposeImages(gimgs);
gtest=TransposeImages(gtest);

% Normalize and whiten 
all_imgs = [gimgs;gtest];
all_imgs_n = FeatureNormalize(all_imgs',10)';
all_imgs_nw = Whiten(all_imgs_n);

gimgs_nw = all_imgs_nw(1:50000,:);
gtest_nw = all_imgs_nw(50000+1:end,:);

clear all_imgs;
clear all_imgs_n;
clear all_imgs_nw;

% Extract 500.000 8x8 random patches from normalized whitened images
patches_nw = CropPatchesFromGS(gimgs_nw,8,500000);

% Randomize the order of patches
some = randperm(size(patches_nw,1));
patches_nw = patches_nw(some,:);
save('patches_nw.mat','patches_nw');

% Compute 1600 centroids using spherical K-Means with 30 iterations
[centroids_n,s_n,s2_n,error_n] = OnlineSphKmeans(patches_nw,1600,30);
save('centroids_n.mat','centroids_n');
fprintf('Spherical K-means error:%f\n',error_n);



% Show the most representative patches from some images
figure
some = randperm(size(gimgs_nw,1));
some = some(1:100);
ShowImgsWithRepresentativePatches(gimgs_nw(some,:),centroids_n,8,gimgs(some,:))


alpha = 0.025;

save('data_before_extracting_features.mat');
 
% Convert the whitened and normalized images to features using the centroids and 4 representative patches from each
% image, this creates a vector of 6400 features per image (1600 centroids *4)

imgfts=ConvertImagesToFeaturesM(gimgs_nw,centroids_n);
imgfts=featureNormalize(imgfts,0);
test_fts = ConvertImagesToFeaturesM(gtest_nw,centroids_n);
test_fts=featureNormalize(test_fts,0);

% Show some features
figure;
some = randperm(size(imgfts,1));
some = some(1:25);
ShowPatches(imgfts(some,:),5)


save('imgfts.mat','imgfts','labels2','-v7.3');
save('test_fts.mat','test_fts','test_labels2','-v7.3');

clear
load('imgfts.mat');
load('test_fts.mat');

% Now run a linear classifier over this
% SVMtrain y predict

model_n = svmtrain(labels2,imgfts,'-s 0 -t 0 -c 50 -h 0 -m 1024');
[pl,acc,pro] = svmpredict(test_labels2,test_fts,model_n);

