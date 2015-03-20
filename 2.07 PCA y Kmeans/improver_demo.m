num =50;
x=rand(500,140);
k=4;
j=[]
lbound=ComputeKmeansBound(x,k)
[cen1,idx1]=Kmeans(x,k);
[cen2,idx2,cost2]=KmeansImprover(x,cen1,idx1,k,500);
for i=1:50
    [c,i]=Kmeans(x,k);
    cost=ComputeKmeansCost(x,c,i);
    j=[j;cost];
end
plot(1:num,j,'r',1:num,repmat(cost2,1,num),'b');
title('Improving Kmeans');
legend('Kmeans','Improved');
xlabel('Experiment');
ylabel('Cost');