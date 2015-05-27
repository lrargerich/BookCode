points=rand(10000,2)*4-2;
donut=points(sqrt(sum(points.^2,2))<2 & sqrt(sum(points.^2,2))>1,:);
scatter(donut(:,1),donut(:,2),4,'filled');