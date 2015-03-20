function XC=ConvertImagesToFeaturesM(X,centroids,zones)
XC = [];
psize = sqrt(size(centroids,2));
imsize = sqrt(size(X,2));

for i=1:size(X,1)
    if mod(i,100)==0
        fprintf('Processed; %d/%d images\n',i,size(X,1));
    end
    patches = CropAllPatchesFromImage(X(i,:),psize,1);
    xx=sum(patches.^2,2);
    cc=sum(centroids.^2,2)';
    xc=patches*centroids';
    z=sqrt(repmat(cc,size(xc,1),1)+(repmat(xx,1,size(xc,2))-2*xc));
    mu=mean(z,2);
    patches = repmat(mu,1,size(z,2))-z;
    patches(patches<0)=0;
    prows=imsize-psize+1;
    pcols=imsize-psize+1;
    patches = reshape(patches,prows,pcols,size(centroids,1));
    halfr = floor(prows/2);
    halfc = floor(pcols/2);
    q1=reshape(sum(sum(patches(1:halfr,1:halfc,:))),1,size(centroids,1));
    q2=reshape(sum(sum(patches((halfr+1):prows,1:halfc,:))),1,size(centroids,1));
    q3=reshape(sum(sum(patches(1:halfr,(halfc+1):pcols,:))),1,size(centroids,1));
    q4=reshape(sum(sum(patches((halfr+1):prows,(halfc+1):pcols,:))),1,size(centroids,1));
    v1=[q1,q2,q3,q4];
    XC=[XC;v1];
end
end

