hidden=200;
x=linspace(-1,1,250000);
y=0.2 + 0.4*x.^2 + 0.3*sin(15*x) + 0.05*cos(50*x);
y1=y;
x=x';
x1=x;
y=y';
data=[x,y];
data=data(randperm(250000),:);
x=data(:,1);
y=data(:,2);
model=ELMTrainRegr(x,y,hidden);
y=ELMPredict(x1,model);
plot(x1,y,'b',x1,y1,'r');

