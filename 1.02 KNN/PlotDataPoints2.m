function KNNPlot2(points,labels,k,classes)
    x=rand(200,2)
    idx=zeros(200,1);
    for i=1:length(x);
        [c,foo]=KNNClassify(x(i,:),points,k,labels);
        idx(i)=c;
    end
    plotDataPoints(points,labels,classes);
    plotDataPoints(x,idx,classes);
    %axis([minx maxx miny maxy]);
end