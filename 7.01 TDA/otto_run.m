clear
load('train.mat')
load('test.mat')

train_size=size(train_data,1);
test_size=size(test_data,1);

all_data = [train_data;test_data];
% First Step is to normalize the data
all_data = FeatureNormalize(all_data,0);

train = all_data(1:train_size,:);
test = all_data(train_size+1:end,:);

clear all_data;
clear train_data;
clear test_data;

walks=10;
walk_length=5;
k=7;

% Second Step is to construct a graph from the data
graph=SlowGraphBuilder(train,k);

%SaveGraph(graph,labels,'otto_graph');

start = train_size;
train_labels=[train_labels;zeros(test_size,1)];

for iter=1:1
    % Output probs will go here
    all_probs=zeros(size(test,1),9);
    for i=1:size(test,1)
       if rand(1,1)>=0.995
           fprintf('Processing %d/%d points\n',i,test_size);
       end
       % Pick the new point
       new_point=test(i,:);
       % Add it to the graph only on iteration 1
       if iter==1
        [graph,train]=AddNewNode(graph,train,new_point,k);
       end
       probs=RandomWalkerClassifier(graph,train_labels,9,start+i,walk_length,walks);
       all_probs(i,:)=probs;
       [m1,m2]=max(probs);
       train_labels(start+i)=m2;   
    end
    %acc=sum(train_labels(train_size+1:end)==test_labels)/test_size;
    %fprintf('Iteration: %d accuracy: %f\n',iter,acc);
end
all_probs=[(1:test_size)',all_probs];
filename = sprintf('otto_result_submit.csv');
fid = fopen(filename, 'w');
fprintf(fid, 'id,Class_1,Class_2,Class_3,Class_4,Class_5,Class_6,Class_7,Class_8,Class_9\n');
fclose(fid);
%dlmwrite(filename, all_probs, '-append', 'precision', '%.6f', 'delimiter', ',');
dlmwrite(filename, all_probs, '-append', 'delimiter', ',');
