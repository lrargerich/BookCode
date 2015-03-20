function patches = CropPatchesFromImages(imgs,L,num)
	% Crop num patches of LxL from a matrix with several random images 
	% each row of imgs should be a grayscale image
	% patches per image
    [m,n]=size(imgs);
    imgsize=sqrt(n);
    patches=[];
    for i=1:num
       if mod(i,1000)==0
	     fprintf('Processing %d/%d images\n',i,size(imgs,1))
	   end
       which_image= 1+floor(rand()*m);
       crop = CropPatches(reshape(imgs(which_image,:),imgsize,imgsize),L,1); 
       patches=[patches;crop];
    end
end