mnist2=mnist2(randperm(size(mnist2,1)),:);
some=mnist2(1:16,:);
for i=1:16
    subplot(8,2,i)
    imshow(reshape(some(i,:),28,28));
    repro=RBMRepresent(some(i,:),W);
    reco=RBMReconstruct(repro,W);
    imshow(reshape(reco,28,28));
    
end