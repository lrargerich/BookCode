dims=100
model=rbmBB(mnist2,dims);
visualize(model.W)
pause;
for i=1:36
    t=rand(1,dims);
    zz=t*model.W';
    zz=zz+model.c;
    subplot(6,6,i);
    imshow(RemapImage(reshape(zz,28,28)))
end