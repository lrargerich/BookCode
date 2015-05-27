load('otto_train_and_test_without_norm.mat')
train=train(1:8000,:);
labels=train_labels(1:8000);
% First Step is to normalize the data
train_n = FeatureNormalize(train,0);

TDA=Mapper(train,50,0.2,20,@CentralityLens,labels);

SaveGraphOtto(TDA.edges_table,TDA.node_table,'otto_tda')