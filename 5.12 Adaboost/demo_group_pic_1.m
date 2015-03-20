gp=imread('group_pic_1.jpg');
load('demo_group_pic_1.mat');
gp=gp(:,:,2);
gp=double(gp);
gp=gp/255;

w=32;


[p1,p2]=size(gp);
map_found=zeros(p1,p2);

max_x = p1-w+1;
max_y = p2-w+1;

found_faces=[];
for i=1:(max_x*max_y)
    fprintf('Processing %f %%\n',i/(max_x*max_y)*100);
    p=CropPatchFromImage(gp,w,1,i);
    ph=HaarFeatures(p,1);
    result=AdaSeqPredict(ph,C,alpha);
    if result==1
      found_faces=[found_faces;reshape(p,1,w*w)];
      x=1+floor((i-1)/max_x);
      y=1+mod(i-1,max_y);
      map_found(x:(x+w-1),y:(y+w-1)) = map_found(x:(x+w-1),y:(y+w-1))+1;
    end
end
save('map_found.mat','map_found');