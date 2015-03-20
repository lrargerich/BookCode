function [new_img,centroids] = KmeansCompressImage(img,patch_size,k)
% Compress image img using patches of patch_x x patch_y size and k total samples
	[imgx,imgy] = size(img);
	[X,i2x,i2y] = DecomposeImage(img,patch_size);
	X=double(X)/255;
	[centroids,idx]=Kmeans(X,k);
	X_recovered = centroids(idx,:);
	new_img = RecomposeImage(X_recovered,imgx,imgy);
end
