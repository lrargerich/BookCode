load('Iris/iris.mat');
% First Step is to normalize the data
iris_n = FeatureNormalize(iris,0);
k=11;
% Second Step is to construct a graph from the data

% Create the distances matrix
d=squareform(pdist(iris_n));

% Start with an empty sparse matrix
graph=sparse(150,150);

% Asociate each point with the closest k points
for i=1:size(d,1)
    [s1,s2]=sort(d(i,:));
    dists=s1(:,2:(k+1));
    neigs=s2(:,2:(k+1));
    for j=1:size(neigs,2)
        graph(i,neigs(j))=dists(j);
        graph(neigs(j),i)=dists(j);
    end
end

% Export this graph so we can visualize it
[r,c]   = find(graph~=0);
v       = nonzeros(graph);
compact = [r,c,v];

filename = 'iris_edges.csv';
fid = fopen(filename, 'w');
fprintf(fid, 'Source,Target,Weight\n');
fclose(fid);
dlmwrite(filename, compact, '-append', 'precision', '%.6f', 'delimiter', ',');

%Write node list and labels
node_list=(1:size(iris,1))';
node_list=[node_list,labels+1];
filename = 'iris_nodes.csv';
fid = fopen(filename, 'w');
fprintf(fid, 'Id,Species\n');
fclose(fid);
dlmwrite(filename, node_list, '-append', 'precision', '%.6f', 'delimiter', ',');

% Third step is the Random Walker classifier 
% We'll classify a random permutation of 20% nodes (30 nodes)
rp = randperm(size(iris,1));
rp = rp(1:(floor(size(iris,1)*0.2)));
valid_labels=labels+1;
new_labels=valid_labels;
new_labels(rp)=0;
% Now do the dance
walks=100;
walk_length=5;
right=0;
wrong=0;
for i=1:size(rp,2)
    node = rp(i);
    probs=RandomWalkerClassifier(graph,labels+1,3,node,walk_length,walks);
    [m1,m2]=max(probs);
    if m2==valid_labels(node)
        right = right+1;
    else
        wrong = wrong+1;
    end
end
acc=100*right/(right+wrong);
fprintf('We got %d right of %d accuracy=%f\n',right,right+wrong,acc);
