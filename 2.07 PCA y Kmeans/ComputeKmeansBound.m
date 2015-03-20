function lbound=ComputeKmeansBound(x,k)
mu=mean(x);
y=bsxfun(@minus,x,mu);
covm=y'*y;
total_var=sum(diag(covm));
[v,e]=eig(covm);
e = sort(diag(e),'descend');
eigensum=sum(e(1:(k-1)));
lbound=total_var-eigensum;
ubound=total_var;
end

