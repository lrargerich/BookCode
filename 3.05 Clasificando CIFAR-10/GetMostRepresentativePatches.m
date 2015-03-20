function [patches_o,patches_w,s2]=GetMostRepresentativePatches(img,centroids,L,num,step,wmat)
	% img is an image in grayscale vectorized in row order
	% centroids are n by pixels centroids
	% L is the size of patches (LxL pixels)
	% num is the number of patches to pull
	% step is the window to scan the image for patches
	% wmat is an optional whitening matrix if present then patches are normalized and whitened

	patches = CropAllPatchesFromImage(img,L,step);
	patches_o = patches;
	
	if exist('wmat','var')
		patches = featureNormalize(patches');
		patches = patches';
		patches = round(patches);
		patches = patches * wmat;
	end
	
	D = (patches * centroids');
	[s1,s2] = sort(max(D,[],2),'descend');
	patches_w = patches(s2(1:num),:);
	patches_o = patches_o(s2(1:num),:);
	s2 = s2(1:num);
end