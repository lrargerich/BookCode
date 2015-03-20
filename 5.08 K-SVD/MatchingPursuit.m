function S = MatchingPursuit(X,D,L,S)
X=X';
m=size(X,2);
n=size(X,1);
k=size(D,2);
if ~exist('S','var')
    S=zeros(k,m);
end
tol=0.0001;
for i=1:m
    x=X(:,i);
    % The residual
    r = x;
    % The sparse representation
    s = zeros(k,1);
    iter=0;
    old_rnorm=1;
    new_rnorm=9999999999999;
    while sum(s~=0)<L && (abs(old_rnorm-new_rnorm)>tol)
       old_rnorm=new_rnorm;
       prod = r'*D;
       [maxval,j]=max(abs(prod));
       s(j) = s(j) + prod(j);
       r = r - prod(j)*(D(:,j));
       iter=iter+1;
       new_rnorm=norm(r);
    end
    S(:,i)=s;
end
end
