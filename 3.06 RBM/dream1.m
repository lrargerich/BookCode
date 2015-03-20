model=rbmBB(faces,4096);
visualize(model.W)
pause;
for i=1:100
t=rand(1,4096);
i=t*model.W';
i=i+model.c;
imshow(RemapImage(reshape(i,64,64)))
pause(0.2);
end