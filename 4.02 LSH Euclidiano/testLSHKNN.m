m=2000;
n=2;
buckets=500;

r=2
max_b=50;
k=5;

% Initialize points and LSH table
X=rand(m,n);
recall_vec=[];
cu1=[];
cu2=[];



for b=1:max_b;
    LSH = LSHCreate(X,buckets,r,b);
    rounds=200;
    recall=0;
    precision=0;
    diffs1=0;
    diffs2=0;
    for i=1:rounds
        point=rand(1,n);
        n1=KNN(point,X,k);
        n2=LSHKNN(LSH,point,k);
        found=0;
        for j=1:size(n2,1)
            if ismember(n2(j,:),n1,'rows')
                found = found+1;
            end
        end
        recall = recall+(found/k);
        dif1=bsxfun(@minus,point,n1);     
        dif1=dif1.^2;
        dif1=sum(dif1,2);
        dif1=mean(dif1);
        dif2=bsxfun(@minus,point,n2);
        dif2=dif2.^2;
        dif2=sum(dif2,2);
        dif2=mean(dif2);
        diffs1=diffs1+dif1;
        diffs2=diffs2+dif2;
    end
    diffs1=diffs1/rounds;
    diffs2=diffs2/rounds;
    cu1=[cu1;diffs1];
    cu2=[cu2;diffs2];
    recall=recall/rounds;
    fprintf('r=%d b=%d Recall: %f \n',r,b,recall);    
    recall_vec=[recall_vec;recall];
end

plot(1:max_b,cu1,1:max_b,cu2);
xlabel('b');
ylabel('Avg RMSE');
title('LSH Average RMSE');
legend('KNN','LSH');
