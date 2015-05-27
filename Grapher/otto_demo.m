J=[];
load('otto_train_and_test_without_norm.mat')
train=train(1:50000,:);
labels=train_labels(1:50000);
% First Step is to normalize the data
train_n = FeatureNormalize(train,0);

walks=100;
walk_length=6;
k=7;

% Second Step is to construct a graph from the data

graph=SlowGraphBuilder(train_n,k);


SaveGraph(graph,labels,'otto_graph');

% Third step is the Random Walker classifier 
% We'll classify a random permutation of 20% nodes (30 nodes)
rp = randperm(50000);
rp = rp(1:(floor(50000*0.2)));
valid_labels=labels;
new_labels=valid_labels;
new_labels(rp)=0;
% Now do the dance

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
fprintf('For k=%d walk lentgh=%d We got %d right of %d accuracy=%f\n',k,walk_length,right,right+wrong,acc);

