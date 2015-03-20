function KNNPlot(points,labels,k)
    minx=min(points(:,1));
    miny=min(points(:,2));
    maxx=max(points(:,1));
    maxy=max(points(:,2));
    x=linspace(minx,maxx,100);
    y=linspace(miny,maxy,100);
    z=zeros(100,100);
    for i=1:length(x);
        for j=1:length(y)
            [c,foo]=KNNClassify([x(i) y(j)],points,k,labels);
            z(i,j)=c;
        end
    end
    contourf(x,y,z);
    %axis([minx maxx miny maxy]);
end
