rows=6;
dist=0;
rownum=1;
j=1;
pos=0;
rp=randperm(5000);


bit_vector=[32,48,64,128,256];
jj=[];
bb=1;
for bb=1:length(bit_vector)
    bit_rate=bit_vector(bb);
    Y_R=tsne(base,[],bit_rate);
    C_R=(W*Y_R)>0;
    total_error=0;
    samples=0;
    for j=1:size(mini,1)
        res=FindHamming(C_R(j,:),C_R,dist);
        for i=1:length(res)
            total_error=total_error+sum((mini(i,:)-mini(res(i),:)).^2);
            samples=samples+1;
        end
    end
    avg_error=total_error/samples;
    jj=[jj;avg_error];
    fprintf('For %d bits total average error is %f\n',bit_rate,avg_error);
end