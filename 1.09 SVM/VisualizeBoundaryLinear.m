function VisualizeBoundaryLinear(X, y, model,margins)
if ~exist('margins', 'var')
    margins=0;
end
tol = 1e-3;
y(y==-1)=0;
w = model.w;
b = model.b;
xp = linspace(min(X(:,1))-1, max(X(:,1))+1, 100);
yp = - (w(1)*xp + b)/w(2);
PlotData(X, y);
hold on;
plot(xp, yp, '-b'); 
hold on

if margins
    points1=X(model.alphas>tol & y==0,:);
    points1=points1(1:2,:);
    points2=X(model.alphas>tol & y==1,:);
    points2=points2(1:2,:);
    plot([points1(1,1),points1(2,1)],[points1(1,2),points1(2,2)],'r');
    % compute slope of margin 1
    m1 = (points1(2,2)-points1(1,2)) / (points1(2,1)-points1(1,1));
    n1 = points1(2,2)*m1 - points1(2,1);
    y1=m1*(min(X(:,1))-1)+n1;
    y2=m1*(max(X(:,1))+1)+n1;
    plot([min(X(:,1))-1,max(X(:,1))+1],[y1,y2],'-.r');
    m1 = (points2(2,2)-points2(1,2)) / (points2(2,1)-points2(1,1));
    n1 = points2(2,2)*m1 - points2(2,1);
    y1=m1*(min(X(:,1))-1)+n1;
    y2=m1*(max(X(:,1))+1)+n1;
    plot([min(X(:,1))-1,max(X(:,1))+1],[y1,y2],'-.r');
end

end
