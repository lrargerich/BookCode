function crop = CropPatches(img,L,num)
	crop = [];
	if ~exist('L','var'), L=16; end
	if ~exist('num','var'), num=1; end
	[n m]= size(img);
	for i=1:num
		crop = [crop;reshape(img(ceil(rand*(n-L+1))+(0:L-1),ceil(rand*(m-L+1))+(0:L-1)),1,L*L)];
	end
end