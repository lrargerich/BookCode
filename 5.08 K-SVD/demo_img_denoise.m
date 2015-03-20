size_img = 200;

img=imread('lena.jpg');
img=img(:,:,3);
img=reshape(img,1,size_img*size_img);
img=double(img);
img=img/255;
img_noise=img;
img_noise=imnoise(img,'gaussian',0,0.005);

figure
subplot(1,3,1),imshow(RemapImage(reshape(img,size_img,size_img)))
subplot(1,3,2),imshow(RemapImage(reshape(img_noise,size_img,size_img)))

% Get all patches from noisy image
img_noise_parts=CropAllPatchesFromImage(img_noise,8,1);
img_noise_parts=ColNormalize(img_noise_parts);

[D2,S2]=KSVD(img_noise_parts,928,3,130);

new_patches=D2*S2;
new_patches=new_patches';

% Reconstruct the image from the new patches
new_img = ReconstructImageFromOverlappingPatches(size_img,new_patches',1);
subplot(1,3,3),imshow(RemapImage(new_img));

figure;
a_face6=reshape(img_noise,size_img,size_img);
subplot(1,3,1)
av_face1=0.001*(a_face6)+0.999*(new_img);
imshow(RemapImage(av_face1));

subplot(1,3,2)
av_face2=0.005*(a_face6)+0.995*(new_img);
imshow(RemapImage(av_face2));

subplot(1,3,3)
av_face3=0.01*(a_face6)+0.99*(new_img);
imshow(RemapImage(av_face3));

