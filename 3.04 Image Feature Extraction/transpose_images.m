function gimgs=TransposeImages(gimgs)
for j=1:50000
    i=gimgs(j,:);
    i=reshape(i,32,32);
    i=i';
    i=reshape(i,1,32*32);
    gimgs(j,:)=i;
end
end