super_mnist=[];
super_labels=[];
super_mnist=zeros(96000,784);
super_labels=zeros(96000,1);
pos=1;
for i=1:size(mnist_train_data,1)
    fprintf('Processing img:%d\n',i);
    label=mnist_train_labels(i,:);
    img=reshape(mnist_train_data(i,:),28,28);
    angle=(rand()*40)-10;
    im2=imrotate(img,angle,'bicubic','crop');
    img=reshape(img,1,28*28);
    im2=reshape(im2,1,28*28);
    super_mnist(pos,:)=img;
    super_mnist(pos+1,:)=im2;
    super_labels(pos,:)=label;
    super_labels(pos+1,:)=label;
    pos=pos+2;
end