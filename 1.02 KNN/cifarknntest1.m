imgs=double(imgs);

r=randperm(50000);
r=r(1:10);
my_ims=imgs(r,:);

for i=1:5

my_image=reshape(my_ims(i,:),32,32,3); 
my_image=permute(my_image,[2 1 3:ndims(my_image)]);

neighbors=KNN(my_ims(i,:),imgs,10);

subplot(5,9,1+((i-1)*9))
imshow(my_image/255);

for j=1:8
    subplot(5,9,(1+((i-1)*9))+j)
    my_image=neighbors(j,:);
    my_image=reshape(my_image,32,32,3); 
    my_image=permute(my_image,[2 1 3:ndims(my_image)]);
    imshow(my_image/255);
end    

end
