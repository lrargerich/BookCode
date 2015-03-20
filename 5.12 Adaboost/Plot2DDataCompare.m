function Plot2DDataCompare(data,labels,predict)
    data1=data(labels==-1,:);
    plot(data1(:,1),data1(:,2),'rx','Markersize',8);
    hold on
    data1=data(labels==1,:);
    plot(data1(:,1),data1(:,2),'bo','Markersize',8);
    hold on
    data1=data(labels==predict,:);
    plot(data1(:,1),data1(:,2),'go','Markersize',10);
end