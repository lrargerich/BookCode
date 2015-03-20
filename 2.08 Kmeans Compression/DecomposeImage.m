function [crops,i2x,i2y] = DecomposeImage(img,patch)
	% Decompose an image in patches of patch x patch pixels
	% if patch is greater than an image size then this explodes and blows your head

	[image_x,image_y] = size(img);
	image_x = double(image_x);
	image_y = double(image_y);

	% First step add padding if image_x is not multiple of patch
	padding_x =  abs(image_x - (ceil(image_x / patch) * patch));
	padding_y = abs(image_y - (ceil(image_y / patch) * patch));

	pad_matrix_y = rand(image_x,padding_y);

	img2 = [img pad_matrix_y];

	pad_matrix_x = rand(padding_x,image_y + padding_y);

	img2 = [img2; pad_matrix_x];

	% Now img2 can be evenly divided in patch x patch patches 

	[i2x,i2y] = size(img2);

	% This MUST be all integer numbers
	numpatches = (i2x*i2y)/(patch*patch);
	patches_in_x = i2x / patch;
	patches_in_y = i2y / patch;

	crops = [];
		for i = 1:numpatches
			row = 1+floor((i-1)/patches_in_y);
			col = 1+ mod(i-1,patches_in_y);
			f1 = 1+((row-1)*patch);
			c1 = 1+((col-1)*patch);
			crops = [crops;reshape(img2(f1:f1+patch-1,c1:c1+patch-1),1,patch*patch)];
		end
end


