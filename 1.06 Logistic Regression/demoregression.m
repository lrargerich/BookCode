%load('datareg.mat');
%x_orig=x;
%y_orig=y;
x_orig=load('ex5Linx.dat');
y_orig=load('ex5Liny.dat');
x1=linspace(-2,2,100)';
i=5
axis([-2 2 -4 4]);
%lambdas=[0,2,10];
lambda=100;

%for l=1:length(lambdas)
for i=2:5;
    xnew=x_orig;
    x11=x1;
    for j=2:i
        xnew=[xnew,x_orig.^j];
        x11=[x11,x1.^j];
    end
    dat=[xnew,y_orig];
    %dat=featureNormalize(dat);
    y=dat(:,size(dat,2));
    x=dat(:,1:(size(dat,2)-1));
    [theta,J]=GD(x,y,0.0815,20000,lambda,@RegressionCost,@RegressionGradient);
    subplot(2,2,i-1);
    plotData(x_orig,y_orig);
    hold on;
    x11=[ones(size(x1,1),1),x11];
    yy=x11*theta;
    plot(x1,yy);
    axis([-2 2 -4 4]);
    hold on
    %s=sprintf('lambda=%d',lambda);
    s=sprintf('degree=%d',i);
    title(s);
end
%legend('points','lambda=0','lambda=2','lambda=10');    
    