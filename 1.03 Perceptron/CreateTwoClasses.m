function [points,labels,w]=CreateTwoClasses(num_points,num_dims)
    points=rand(num_points,num_dims)-0.5;
    w=rand(1,num_dims+1)-0.5;
    x=[ones(size(points,1),1),points];
    dp = x*w';
    labels=(dp>0);
end