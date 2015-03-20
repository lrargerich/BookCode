function patches = CropAllPatchesFromImage(img,L,step)
	if ~exist('step','var'), step=1; end
    imsize = sqrt(size(img,2));
    
	% Crop all overlapping patterns of LxL pixels from a grayscale image
	patches = [];
	img=reshape(img,imsize,imsize)';
    p1 = size(img,1);
	p2 = size(img,2);
	
	w = L;
	max_x = p1-w+1;
	max_y = p2-w+1;
	for x= 1:step:max_x
		for y=1:step:max_y
			crop1 = img(x:(x+w-1),y:(y+w-1));
            crop = reshape(crop1',1,L*L);
    		patches = [patches;crop];
		end
	end
end