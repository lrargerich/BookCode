function img_orgb=HighlightPatches(img,patches,img_o)
	% This function takes an image img and some patches
	% from the image (patches)
	% finds where the patches occurr in the image and highlights them in red
	% if img_o is supplied then img_o is highlighted at the same position as img!

	if ~exist('img_o','var'), img_o=img; end

	imsize = sqrt(size(img,2));
	num = size(patches,1);
	psize = sqrt(size(patches,2));

	channel=1;

	% Convert image to rgb
	img = reshape(img,imsize,imsize);
	img_o = reshape(img_o,imsize,imsize);

	max_scan = imsize - psize + 1;

	imgrgb=uint8(cat(3,img,img,img));	
	img_orgb=uint8(cat(3,img_o,img_o,img_o));	


	for i=1:size(patches,1)
		patch = reshape(patches(i,:),psize,psize);
		for x=1:max_scan
			for y=1:max_scan
				% Compare patches between img and patch
				if patch==img(x:(x+psize-1),y:(y+psize-1))
					img_orgb(x:(x+psize-1),y:(y+psize-1),channel)=img_orgb(x:(x+psize-1),y:(y+psize-1),channel)*2;
				end
			end
		end
	end
end
