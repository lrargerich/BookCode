points=rand(10000,2)*4-2;
data=points(sqrt(sum(points.^2,2))<2 & sqrt(sum(points.^2,2))>1,:);
scatter(data(:,1),data(:,2),4,'filled');