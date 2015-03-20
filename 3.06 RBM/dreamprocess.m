mnist2=mnist2(randperm(size(mnist2,1)),:);
i = floor(rand(1,1)*5900+1);
%dream=mnist2(i,:);
dream=rand(1,784);
for z=1:4
    subplot(1,5,z)
    imshow(~RemapImage(reshape(dream,28,28)))
    rep = RBMRepresent(dream,W);
    dream = RBMReconstruct(rep,W);
end
    