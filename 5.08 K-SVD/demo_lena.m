img=imread('lena.jpg')

sx=size(img,1);

lena=img(:,:,2);
lena=double(lena);
lena=lena/255;
imshow(lena)
lenavec=reshape(lena',1,sx*sx);

lenin=imnoise(lena,'gaussian',0,0.005);
leninvec=reshape(lenin',1,sx*sx);

figure
subplot(1,3,1),imshow(lena)
subplot(1,3,2),imshow(lenin)

patches=CropAllPatchesFromImage(leninvec,8,1);

[D2,S2]=KSVD(patches,518,3,130);

new_patches=D2*S2;
new_patches=new_patches';

new_lena=ReconstructImageFromOverlappingPatches(200,new_patches,1);

subplot(1,3,3),imshow(RemapImage(new_lena));