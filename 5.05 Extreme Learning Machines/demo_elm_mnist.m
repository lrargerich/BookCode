j=[];
C=1;
for hidden=1000:1000:10000
    model = ELMTrain( train, labels_train+1, hidden);
    sc = ELMPredict( test, model);
    [m1,idx]=max(sc);
    pre=sum((idx'==(labels_test+1)))/length(idx);
    
    j=[j;pre];
    fprintf('For %d hidden layers precision is %f\n',hidden,pre);
end
errors=test(idx'~=(labels_test+1),:);
errors=errors(randperm(size(errors,1)),:);
for z=1:25
   subplot(5,5,z)
   imshow(reshape(errors(z,:),28,28))
end
figure
plot(1000:1000:10000,j);
title('ELM Precision for MNIST');
xlabel('# of hidden units');
ylabel('precision');

