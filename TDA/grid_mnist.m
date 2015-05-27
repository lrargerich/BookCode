load('Mnist/mnist.mat');

% Grid-Seach for: K
% Number of RWalks
% Walk Length

% First Step is to normalize the data
mnist_n = mnist;
mini_labels=labels;
k=5;
% Second Step is to construct a graph from the data

graph=SlowGraphBuilder(mnist_n,k);

% Third step is the Random Walker classifier 
% We'll classify a random permutation of 20% nodes (30 nodes)
rp = randperm(size(mini_mnist,1));
rp = rp(1:(floor(size(mini_mnist,1)*0.2)));
valid_labels=mini_labels+1;
new_labels=valid_labels;
new_labels(rp)=0;
% Now do the dance
walks=20;
walk_length=4;
J=[];
for walk_length=1:11
    right=0;
    wrong=0;
    new_labels=valid_labels;
    new_labels(rp)=0;
    for i=1:size(rp,2)
        node = rp(i);
        probs=RandomWalkerClassifier(graph,new_labels,10,node,walk_length,walks);
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
plot(1:11,J);
xlabel('Walk Length');
ylabel('Accuracy');
title('MNIST Walk Length');