s1=imread('scene1.jpg');
s2=imread('robot1.jpg');

s1=double(s1(:,:,2))/255;
s2=double(s2(:,:,2))/255;

beta=1/5;

% Mixing Matrix
A=[4/5 beta;1/2 2/3];

x1=A(1,1)*s1+A(1,2)*s2;
x2=A(2,1)*s1+A(2,2)*s2;

[m,n]=size(x1);

subplot(3,2,1),imshow(s1)
subplot(3,2,2),imshow(s2)
subplot(3,2,3),imshow(x1)
subplot(3,2,4),imshow(x2)


x1=reshape(x1,m*n,1);
x2=reshape(x2,m*n,1);

mix=[x1,x2];
[w,h]=NMFMult(mix,2,1000);
subplot(3,2,5)
imshow(RemapImage(reshape(w(:,1),200,200)))
subplot(3,2,6)
imshow(RemapImage(reshape(w(:,2),200,200)))