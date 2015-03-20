mnist2=mnist2(randperm(size(mnist2,1)),:);
for i=1:64
    dream=mnist2(i,:);
    for z=1:100
        rep = RBMRepresent(dream,W);
        dream = RBMReconstruct(rep,W);
    end
    subplot(8,8,i)
    imshow(RemapImage(reshape(dream,28,28)))
end
    