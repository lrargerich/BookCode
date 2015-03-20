function PlotClasses(x,idx,w,the_title)
if ~exist('the_title','var')
        the_title='';
end
x=[ones(size(x,1),1),x];
%idx=(x*w'>1);
class1=x(idx==0,:);
class2=x(idx==1,:);
plot(class1(:,2),class1(:,3),'rx','MarkerSize',7);
hold on
plot(class2(:,2),class2(:,3),'bo','MarkerSize',7);
if exist('w','var')
    hold on
    max_x = max(x(:,2));
    min_x = min(x(:,2));
    max_y = max(x(:,3));
    min_y = min(x(:,3));
    plot_x=[min_x,max_x];
    plot_y= (-w(1) - (w(2).*plot_x))/w(3);
    plot(plot_x,plot_y);
    title(the_title);
    axis([min_x,max_x,min_y,max_y]);
end
end
