[points,labels,w]=CreateTwoClasses(90,2);
figure
PlotClasses(points,labels,w);
pause;
[theta,errors]=AnimatedPerceptron(points,labels,0.01,100);
figure
PlotClasses(points,labels,theta);