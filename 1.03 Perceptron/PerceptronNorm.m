function [theta,errors] = PerceptronNorm(X,y,alpha,iter,theta)
    if ~exist('theta','var')
        theta=sparse(rand(size(X,2)+1,1));
    end
    X=[ones(size(X,1),1),X];
    for i=1:iter
        errors = 0;
        for j=1:size(X,1)
            fprintf('j=%d\n',j);
            dp = (X(j,:) * theta) >0;           
            error = y(j)-dp;
            if error~=0
                errors = errors+1;
                theta = sparse(theta + (alpha * error * log(1+X(j,:)')));
            end
        end
        fprintf('Pass:%d errors:%d\n',i,errors);
        if errors==0
            break;
        end
    end
end