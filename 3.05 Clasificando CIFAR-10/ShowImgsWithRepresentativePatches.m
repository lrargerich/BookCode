function ShowImgsWithRepresentativePatches(gimgs,centroids_n,lado,gimgs_o)
	% Given the images gimgs and centroids
	% this finds the lado*lado most representative patches
	% from each image using gimgs_o for display
	if ~exist('gimgs_o','var'), gimgs_o=gimgs; end
	rp = randperm(size(gimgs,1));
	rp = rp(1:(lado^2));
	% Now we have lado^2 random images
	figure;
	for i=1:(lado^2)
		[patches,s2]=GetMostRepresentativePatches(gimgs(rp(i),:),centroids_n,8,1,1);
		imgrgb=HighlightPatches(gimgs(rp(i),:),patches,gimgs_o(rp(i),:));
		% Remap the image to 0..255
		subplot(lado,lado,i),imshow(imgrgb);
	end
end



