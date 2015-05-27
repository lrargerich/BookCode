load('Mnist/mini_mnist.mat');
% First Step is to normalize the data
mnist_n = mnist;
mini_labels=labels;
k=5;
% Second Step is to construct a graph from the data

graph=SlowGraphBuilder(mnist_n,k);

% Export this graph so we can visualize it
[r,c]   = find(graph~=0);
v       = nonzeros(graph);
compact = [r,c,v];

filename = 'mnist_edges.csv';
fid = fopen(filename, 'w');
fprintf(fid, 'Source,Target,Weight\n');
fclose(fid);
dlmwrite(filename, compact, '-append', 'precision', '%.6f', 'delimiter', ',');

%Write node list and labels
node_list=(1:60000)';
node_list=[node_list,mini_labels];
filename = 'mnist_nodes.csv';
fid = fopen(filename, 'w');
fprintf(fid, 'Id,Digit\n');
fclose(fid);
dlmwrite(filename, node_list, '-append', 'precision', '%.6f', 'delimiter', ',');

% Third step is the Random Walker classifier 
% We'll classify a random permutation of 20% nodes (30 nodes)
rp = randperm(size(mini_mnist,1));
rp = rp(1:(floor(size(mini_mnist,1)*0.2)));
valid_labels=mini_labels+1;
new_labels=valid_labels;
new_labels(rp)=0;
% Now do the dance
walks=10;
walk_length=4;
J=[];
for iters=1:1
    right=0;
    wrong=0;
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