function XC=SPHKmeansImagesToFeatures(X,centroids)
psize = sqrt(size(centroids,2));
imsize = sqrt(size(X,2));
num_cen=size(centroids,1);
half=floor(imsize/2);
XC = zeros(size(X,1),4*num_cen);
for i=1:size(X,1)
    if mod(i,100)==0
      fprintf('Processed; %d/%d images\n',i,size(X,1));
    end
    % split the image in 4 zones
    img=reshape(X(i,:),imsize,imsize);
    z1=img(1:half,1:half);
    z2=img(1:half,half+1:end);
    z3=img(half+1:end,1:half);
    z4=img(half+1:end,half+1:end);
    % Now compute the feature for each zone;
    p1=CropAllPatchesFromImage(reshape(z1,1,half*half),psize,1);
    p2=CropAllPatchesFromImage(reshape(z2,1,half*half),psize,1);
    p3=CropAllPatchesFromImage(reshape(z3,1,half*half),psize,1);
    p4=CropAllPatchesFromImage(reshape(z4,1,half*half),psize,1);
    p1_f=p1*centroids';
    p2_f=p2*centroids';
    p3_f=p3*centroids';
    p4_f=p4*centroids';
    f1=sum(p1_f);
    f2=sum(p1_f);
    f3=sum(p1_f);
    f4=sum(p1_f);
    XC(i,:)=[f1,f2,f3,f4];
end
end
