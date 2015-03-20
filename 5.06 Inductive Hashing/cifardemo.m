rows=6;
dist=0;
rownum=1;
j=1;
pos=0;
rp=randperm(5000);
while(rownum<rows+1)
    res=[];
    j=rp(j);
    res=FindHamming(C2(j,:),C2,dist);
    res=[j;res];
    if length(res)>6
        res=res(1:6);
    end
    if length(res)==6 
        for i=1:length(res)
            pos = pos+1;
            subplot(rows,6,pos)
            imshow(rot90(reshape(mini(res(i),:),32,32,3),3));
        end
        rownum=rownum+1;
    end
    j=j+1;
end