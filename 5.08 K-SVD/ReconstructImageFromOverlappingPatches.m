function img=ReconstructImageFromOverlappingPatches(imsize,patches,step)
    if ~exist('step','var'), step=1; end
    psize = sqrt(size(patches,2));
	% Crop all overlapping patterns of LxL pixels from a grayscale image
	img=zeros(imsize,imsize);
    cou=zeros(imsize,imsize);
	w = psize;
    p1=imsize;
    p2=imsize;
	max_x = p1-w+1;
	max_y = p2-w+1;
    num_patch=1;
	for x= 1:step:max_x
		for y=1:step:max_y
            patch=patches(num_patch,:);
            num_patch=num_patch+1;
            f1=x;
            f2=x+w-1;
            c1=y;
            c2=y+w-1;
			img(x:(x+w-1),y:(y+w-1)) = img(x:(x+w-1),y:(y+w-1))+reshape(patch,psize,psize)';
            cou(x:(x+w-1),y:(y+w-1)) = cou(x:(x+w-1),y:(y+w-1))+1;
		end
	end
img = img./cou;
end