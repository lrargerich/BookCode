walks_vec=[5,10,25,50,100,200];

walk_length=4;
walks=20;
for iter=1:1
    right=0;
    wrong=0;
    for i=1:size(rp,2)
        node = rp(i);
        probs=RandomWalkerClassifier(graph,new_labels,9,node,walk_length,walks);
        [m1,m2]=max(probs);
        new_labels(node)=m2;
        if m2==valid_labels(node)
            right = right+1;
        else
            wrong = wrong+1;
        end
    end
    acc=100*right/(right+wrong);
    J=[J;acc];
    fprintf('We got %d right of %d accuracy=%f\n',right,right+wrong,acc);
end
J=[];
for l=1:11
    walks=10;
    right=0;
    wrong=0;
    for i=1:size(rp,2)
        node = rp(i);
        probs=RandomWalkerClassifier(graph,new_labels,9,node,l,walks);
        [m1,m2]=max(probs);
        new_labels(node)=m2;
        if m2==valid_labels(node)
            right = right+1;
        else
            wrong = wrong+1;
        end
    end
    acc=100*right/(right+wrong);
    J=[J;acc];
    fprintf('With %d walks of %d length We got %d right of %d accuracy=%f\n',walks,walk_length,right,right+wrong,acc);
end
plot(1:11,l);
