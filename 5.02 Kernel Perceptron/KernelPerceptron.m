function model=KernelPerceptron(X,y,alpha,iter,kernel)
X=[ones(size(X,1),1),X];
error_points=sparse(size(X,1),size(X,2));
err=zeros(size(X,1),1);

for ii=1:iter
    errors=0;
    for i=1:size(X,1)
        x = X(i,:);
        idx = find(err~=0);
        total=0;
        for j=1:length(idx)
            errpt = error_points(idx(j),:);
            k = kernel(x,errpt);
            total=total+(alpha*y(idx(j))*err(idx(j))*k);
        end
        if sign(total)~=y(i)
           err(i)=err(i)+1;
           error_points(i,:)=x;
           errors=errors+1;
        end
    end
    fprintf('Iteration:%d errors:%d points in memory:%d\n',ii,errors,sum(err~=0));
    if errors==0
      break;
    end
end

model.kernel=kernel;
model.error_points=error_points;
model.err=err;
model.alpha=alpha;
model.y=y;
end