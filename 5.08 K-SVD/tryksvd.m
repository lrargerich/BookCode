%load('olivettifaces.mat');
%faces=faces';
patches = CropPatchesFromGS(faces,8,100000);
patches_n=ColNormalize(patches);
[D,S,J]=KSVD(patches_n,717,3,60);

save('dictionary.mat','D','S');