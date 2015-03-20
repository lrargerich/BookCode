function PlotClasses(x,idx,w)
%ax = [min(x(:,1)-1),max(x(:,1)+1),min(x(:,2)-1),max(x(:,2)+1)];
idx(idx==-1)=0;
x=[ones(size(x,1),1),x];
%idx=(x*w'>1);
class1=x(idx==0,:);
class2=x(idx==1,:);
plot(class1(:,2),class1(:,3),'rx','MarkerSize',9);
hold on
plot(class2(:,2),class2(:,3),'bo','MarkerSize',9);
%axis(ax);
%axis([min(x(:,1)-1),max(x(:,1)+1),min(x(:,2)-1),max(x(:,2)+1)])
%axis([1 9 0 9]);
if exist('w','var')
    hold on
    max_x = max(x(:,2));
    min_x = min(x(:,2));
    plot_x=[min_x,max_x];
    plot_y= (-w(1) - (w(2).*plot_x))/w(3);
    plot(plot_x,plot_y);
end
end
