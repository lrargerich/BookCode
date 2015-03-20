function theta=FSS(X,y,tol)
if ~exist('tol', 'var') 
    tol=0.05;
end

X=[ones(size(X,1),1),X];
m=size(X,1);
n=size(X,2);
theta=zeros(size(X,2),1);
epsilon=0.0005;

% Initially the residual is y
R=y
prod = R'*X;
[maxval,index]=max(abs(prod));
iter=0;

all_thetas=[];

while abs(maxval)>tol
    iter=iter+1;
    theta(index)=theta(index)+(sign(prod(index))*epsilon);
    R=(y-X*theta);
    prod = R'*X;
    [maxval,index]=max(abs(prod));
    fprintf('Iteration: %d Max Residual = %f (%d)\n',iter,maxval,sign(prod(index)));
end
fprintf('Solved in %d iterations\n',iter);
end