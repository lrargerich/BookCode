function img = RecomposeImage(patches,image_x,image_y)
	% Recompose a x*y sized image from n patches of L*L pixels
	patch = sqrt(size(patches,2));
	
	image_x = double(image_x);
	image_y = double(image_y);

	% First step determine the padding 
	padding_x =  abs(image_x - (ceil(image_x / patch) * patch));
	padding_y = abs(image_y - (ceil(image_y / patch) * patch));

	i2x = image_x + padding_x;
	i2y = image_y + padding_y;

	% i2x & i2y is the size to reconstruct from the patches
	img = zeros(i2x,i2y);

	% This MUST be all integer numbers
	numpatches = (i2x*i2y)/(patch*patch);
	patches_in_x = i2x / patch;
	patches_in_y = i2y / patch;

	for i=1:size(patches,1)
		row = 1+floor((i-1)/patches_in_y);
		col = 1+ mod(i-1,patches_in_y);
		f1 = 1+((row-1)*patch);
		c1 = 1+((col-1)*patch);
		crop = reshape(patches(i,:),patch,patch);
		img(f1:f1+patch-1,c1:c1+patch-1)=crop;
	end
	img=img(1:image_x,1:image_y);
end	