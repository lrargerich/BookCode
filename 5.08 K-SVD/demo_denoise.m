clear;
load('demo_denoise.mat');
load('dictionary.mat');
a_face=double(a_face/255);
a_face_noise=a_face;

% This is the face with noise
%destroy=floor(1+rand(1,2000)*4096);
%a_face_noise(:,destroy)=0;

a_face_noise=imnoise(a_face,'gaussian',0,0.001);

figure
subplot(1,5,1),imshow(RemapImage(reshape(a_face,64,64)))
subplot(1,5,2),imshow(RemapImage(reshape(a_face_noise,64,64)))

% Get all patches from noisy image
a_face_noise_parts=CropAllPatchesFromImage(a_face_noise,8,1);
a_face_noise_parts=ColNormalize(a_face_noise_parts);

[D2,S2]=KSVD(a_face_noise_parts,928,3,130);

new_patches=[];
new_patches2=[];

L=3;

%a_face_noise_parts=CropAllPatchesFromImage(a_face_noise,8,8);
%a_face_noise_parts=ColNormalize(a_face_noise_parts);

%Process each patch of noisy image
for i=1:size(a_face_noise_parts,1)
    fprintf('Reconstructing patch %d/%d\n',i,size(a_face_noise_parts,1));
    patch=a_face_noise_parts(i,:);
    % Get sparse vector for this patch
    S = MatchingPursuit(patch,D2,L);
    S3 = MatchingPursuit(patch,D,L);
    % Compute reconstruction
    new_patch = D2*S;
    new_patch2 = D*S3;
    new_patches=[new_patches;new_patch'];
    new_patches2=[new_patches2;new_patch2'];
end

new_patches3=D2*S2;
new_patches3=new_patches3';

% Reconstruct the image from the new patches
new_face = ReconstructImageFromOverlappingPatches(64,new_patches',1);
new_face2 = ReconstructImageFromOverlappingPatches(64,new_patches2',1);
new_face3 = ReconstructImageFromOverlappingPatches(64,new_patches3',1);
subplot(1,5,3),imshow(RemapImage(new_face));
subplot(1,5,4),imshow(RemapImage(new_face2));
subplot(1,5,5),imshow(RemapImage(new_face3));


figure;
a_face6=reshape(a_face_noise,64,64);
subplot(1,5,1)
av_face1=0.001*(a_face6)+0.999*(new_face3);
imshow(RemapImage(av_face1));

subplot(1,5,2)
av_face2=0.002*(a_face6)+0.998*(new_face3);
imshow(RemapImage(av_face2));

subplot(1,5,3)
av_face3=0.003*(a_face6)+0.997*(new_face3);
imshow(RemapImage(av_face3));

subplot(1,5,4)
av_face4=0.005*(a_face6)+0.995*(new_face3);
imshow(RemapImage(av_face4));

subplot(1,5,5)
av_face5=0.01*(a_face6)+0.99*(new_face3);
imshow(RemapImage(av_face5));