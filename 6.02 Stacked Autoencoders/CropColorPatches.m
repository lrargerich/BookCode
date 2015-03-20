function crop = CropColorPatches(img,L,num)
	crop = [];
	if ~exist('L','var'), L=16; end
	if ~exist('num','var'), num=1; end
	[n m channels]= size(img);
	for i=1:num
        img_1=img(:,:,1);
        img_2=img(:,:,2);
        img_3=img(:,:,3);
        pos_x=ceil(rand*(n-L+1))+(0:L-1);
        pos_y=ceil(rand*(m-L+1))+(0:L-1);
        r1= reshape(img_1(pos_x,pos_y),1,L*L);
        r2= reshape(img_2(pos_x,pos_y),1,L*L);
        r3= reshape(img_3(pos_x,pos_y),1,L*L);
        r=[r1(:);r2(:);r3(:)]';
        crop = [crop;r];
	end
end