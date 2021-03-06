function [theta,errors] = AnimatedPerceptron(X,y,alpha,iter,theta)
    if ~exist('theta','var')
        theta=rand(size(X,2)+1,1);
    end
    X=[ones(size(X,1),1),X];
    for i=1:iter
        errors = 0;
        for j=1:size(X,1)
            %fprintf('row:%d errors%d\n',j,errors);
            dp = (X(j,:) * theta) >0;
            error = y(j)-dp;
            if error~=0
                errors = errors+1;
                %theta = theta + (alpha * error * log(1+X(j,:)'));
                theta = theta + (alpha * error * X(j,:)');
                
            end
        end
        fprintf('Pass:%d errors:%d\n',i,errors);
        figure(1);
        clf;
        the_title=sprintf('Iteration %d Errors %d',i,errors);
        PlotClasses(X(:,2:end),y,theta,the_title);
        pause;
        if errors==0
            break;
        end
    end
end