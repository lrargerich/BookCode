k_values=[1,3,5,7,9,11,13,15]
cost=zeros(1,length(k_values));
imgs=double(imgs);
points=14000;
rounds=3;

for zz=1:rounds
fprintf('Round %d of %d\n',zz,rounds);
rp=randperm(size(imgs,1));
rp=rp(1:points);

all_classes=zeros(points,points-1);


imgs1=imgs(rp,:);
labels1=labels(rp);

fprintf('Creating Matrix of neighboring classes\n');
for i=1:size(imgs1,1)
    if mod(i,100)==0
       fprintf('Processed points:%d\n',i); 
    end
    my_img=imgs1(i,:);
    [class,prob,neighbors,classes]=KNNClassify(my_img,imgs1,points-1,labels1);
    all_classes(i,:)=classes;
end

for j=1:length(k_values)
    k=k_values(j);
    classes=zeros(points,1);
    for i=1:points
        classes(i)=mode(all_classes(i,1:k));
    end
    pre = sum(classes==labels1)/length(labels1);
    cost(j)=cost(j)+pre;
    fprintf('Total precision for k=%d is %f\n',k,pre);
end

end
cost=cost./rounds;
plot(k_values,cost);
