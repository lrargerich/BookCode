%data=rand(20000,20);
data=mnist;
code_size=15;
J=[];
[codes,centroids,values]=KmeansHashing(data,code_size,30);
for i=1:code_size
    cost=ComputeKmeansCost(data,centroids{i},bi2de((codes(:,1:i)))+1);
    J=[J;cost];
end
plot(J);