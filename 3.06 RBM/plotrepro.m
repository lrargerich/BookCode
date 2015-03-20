mnist2=mnist2(randperm(size(mnist2,1)),:);
some=mnist2(1:100,:);
for i=1:25
    subplot(5,5,i)
    repro=RBMRepresent(some(i,:),W);
    imshow(reshape(repro,20,20));
end