j=[]
for i=2:2000
    fprintf('dim %d\n',i);
    x=rand(200,i);
    d=BuildDistanceMatrix(x);
    j=[j;std(reshape(d,1,200*200))/mean(reshape(d,1,200*200))];
end    