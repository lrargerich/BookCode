s1=imread('machines.jpg');
s2=imread('arnie.jpg');

s1=double(s1(:,:,2))/255;
s2=double(s2(:,:,2))/255;

beta=3/5;

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

sbar=ICA(mix);

s1bar=sbar(:,1);
s2bar=sbar(:,2);

s1bar=Scale(s1bar);
s2bar=Scale(s2bar);

s1bar=reshape(s1bar,m,n);
s2bar=reshape(s2bar,m,n);

subplot(3,2,5),imshow(s1bar);
subplot(3,2,6),imshow(s2bar);