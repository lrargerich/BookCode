function imgs=TransposeColorImages(imgs)
for j=1:50000
    i=imgs(j,:);
    i=reshape(i,32,32,3);
    i(:,:,1)=i(:,:,1)';
    i(:,:,2)=i(:,:,2)';
    i(:,:,3)=i(:,:,3)';
    i=reshape(i,1,32*32*3);
    imgs(j,:)=i;
end
end