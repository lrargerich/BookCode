function gimgs=TransposeImages(gimgs)
[m,n]=size(gimgs);
n=sqrt(n);
for j=1:m
    i=gimgs(j,:);
    i=reshape(i,n,n);
    i=i';
    i=reshape(i,1,n*n);
    gimgs(j,:)=i;
end
end