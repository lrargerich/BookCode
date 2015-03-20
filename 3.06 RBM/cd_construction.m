x=[1,1,0,0,0,1,1,1,1];
n=3;
W=rand(9,2)
y1=Sigmoid(x*W);
r=rand(1,2);
y=y1>r;
Epos = x'*y;
n=3;
for i=1:n
    xnew=Sigmoid(y*W');
    r=rand(1,9);
    xnew=xnew>r
    xnew(1)=1;
    y1=Sigmoid(xnew*W);
    r=rand(1,2);
    y=y1>r;
end

