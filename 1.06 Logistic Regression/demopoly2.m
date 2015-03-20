load('datareg.mat');
x=data(:,1);
y=data(:,2);
y=y-mean(y);
x1=linspace(-8,8,100)';
for i=2:5
    xnew=x;
    x11=x1;
    for j=2:i
        xnew=[xnew,x.^j];
        x11=[x11,x1.^j];
    end
    xnew=featureNormalize(xnew,0);
    [theta,J]=GD(xnew,y,0.15,1000,0,@RegressionCost,@RegressionGradient);
    plotData(x,y);
    hold on;
    x11=[ones(size(x1,1),1),x11];
    yy=x11*theta;
    plot(x1,yy);
    pause
end
    
    