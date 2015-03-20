%load('faces_0_1.mat');

%randomize
faces=faces(randperm(400),:);
%show the randomized faces
%figure
%ShowFacesImagesInGrid(faces,20);

% Crop 50.000 8x8 random patches from images;
%fprintf('Cropping patches\n');
patches=CropPatchesFromGS(faces,8,50000);

% Show 64 of these
%figure
patches = patches(randperm(50000),:);
%ShowPatches(patches,8);
patches=ColNormalize(patches);

% Run KSVD
[D,S,J]=KSVD(patches,256,3,40);

% Show the dictionary we just learned 
%figure
%ShowPatches(D',16);

% Get a single face
%figure
a_face=faces(1,:);
imshow(reshape(a_face,64,64));

% Apply some destruction to this face
points=1+floor(rand(1,3200)*4096);
a_noisy_face=a_face;
a_noisy_face(points)=0;
%imshow(reshape(a_noisy_face,64,64));


for i=1:10
% Now get all patches from our noisy image
noisy_patches=CropAllPatchesFromImage(a_noisy_face,8,1);
% Get sparse representation for all the noisy patches using learned
% dictionary
S = MatchingPursuit(noisy_patches,D,3);
% Compute the new patches
new_patches = D*S;
new_face = ReconstructImageFromOverlappingPatches(64,new_patches,1);
figure
imshow(new_face)
a_noisy_face=reshape(new_face,1,64*64);
end