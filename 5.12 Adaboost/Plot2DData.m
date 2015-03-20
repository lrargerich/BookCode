%labels in +1 -1 format
function Plot2DData(data,labels)
    data1=data(labels==-1,:);
    plot(data1(:,1),data1(:,2),'rx');
    hold on
    data1=data(labels==1,:);
    plot(data1(:,1),data1(:,2),'bo');
end
    