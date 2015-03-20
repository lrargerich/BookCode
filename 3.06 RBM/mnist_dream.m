[W,J]=LearnBinaryRBMb(mnist2,400,1,0.01,1000,0.90,100,W); 
vis = W(2:end,1:400);
visualize(vis);
the_dream=zeros(64,784);
for i=1:64
    a_dream=double(rand(1,784)>0.5);
    for zz=1:10
        a_rep = RBMRepresent(a_dream,W);
        a_dream=RBMReconstruct(a_rep,W);
    end
    the_dream(i,:)=RemapImage(a_dream);
    subplot(8,8,i)
    imshow(RemapImage(reshape(a_dream,28,28)))
    %pause(0.5);
end


