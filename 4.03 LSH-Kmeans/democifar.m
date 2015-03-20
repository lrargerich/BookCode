rows=6;
k=5;
rownum=1;
j=1;
pos=0;
rp=randperm(50000);
while(rownum<rows+1)
    res=[];
    j=rp(j);
    [items,res]=SearchKmeansLSH(KLSH,data(j,:),k);
    res=[j;res];
    if length(res)>6
        res=res(1:6);
    end
    if length(res)==6 
        for i=1:6
            pos = pos+1;
            subplot(rows,6,pos)
            imshow(rot90(reshape(data(res(i),:),32,32,3),3));
        end
        rownum=rownum+1;
    end
    j=j+1;
end