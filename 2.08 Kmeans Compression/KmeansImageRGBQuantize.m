function [new_img,centroids] = KmeansImageRGBQuantize(img,k)
	A = img;
	A = double(A) / 255; % Divide by 255 so that all values are in the range 0 - 1
	% Size of the image
	img_size = size(A);
	X = reshape(A, img_size(1) * img_size(2), 3);
	%[centroids,idx]=Kmeans(X,k);
	[centroids,idx]=onlinekmeans(X,k);
	X_recovered = centroids(idx,:);

    new_img = reshape(X_recovered, img_size(1), img_size(2), 3);
end
