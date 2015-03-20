function theta=NormalEquation(X,y,lambda)
m=size(X,1);
n=size(X,2);
X=[ones(m,1),X];
I=eye(n+1,n+1);
I(1,1)=0;
I=I*lambda;
theta=(inv(X'*X+I))*X'*y;
end