function patches = CropPatchesFromGS(imgs,L,num)
	% Crop num patches of LxL from a matrix with several random images 
	% each row of imgs should be a grayscale image
	% patches per image
	ppi = round(num/size(imgs,1));
	patches = [];
	imgsize=sqrt(size(imgs,2));
	
	for i=1:size(imgs,1)
		if mod(i,1000)==0
			fprintf('Processing %d/%d images\n',i,size(imgs,1))
		end
		crop = CropPatches(reshape(imgs(i,:),imgsize,imgsize),L,ppi);
		patches=[patches;crop];
	end
end

