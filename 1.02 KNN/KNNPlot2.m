function KNNPlot2(points,labels,k,classes)
    figure
    minx=min(points(:,1));
    miny=min(points(:,2));
    maxx=max(points(:,1));
    maxy=max(points(:,2));
    x=rand(50000,2);
    x(:,1)=(x(:,1)*(maxx-minx))+minx;
    x(:,2)=(x(:,2)*(maxy-miny))+miny;
    idx=zeros(200,1);
    for i=1:length(x);
        [c,foo]=KNNClassify(x(i,:),points,k,labels);
        idx(i)=c;
    end
    plotDataPoints(x,idx,classes);
    hold on
    plotDataPoints(points,labels,classes);
   
    %axis([minx maxx miny maxy]);
end