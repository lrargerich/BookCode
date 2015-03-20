train_rows;
train_cols;
train_sent;
train_data=sparse(rows,cols,ones(size(rows)));
train_data=train_data(1:(size(train_data,1)-1),:);
clear rows;
clear cols;

test_rows;
test_cols;
test_sent;
test_data=sparse(rows,cols,ones(size(rows)));
test_data=test_data(1:(size(test_data,1)-1),:);
clear rows;
clear cols;

save('popcorn.mat','train_data','test_data','sent_train','sent_test');