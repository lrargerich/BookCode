function [w,J] = SVMPegasos(x,y,lambda,iterations)
[m,d] = size(x);
w = zeros(d,1);
t = 1;
J=[];
for (i=1:iterations)      % iterations over the full data
    for (tau=1:m)      % pick a single data point
        if (y(tau)*x(tau,:)*w < 1)  
            w = (1-1/t)*w + 1/(lambda*t)*y(tau)*x(tau,:)';
        else
            w = (1-1/t)*w;
        end
        t=t+1;         % increment counter
    end
    c1=1-(y.*(x*w));
    c1(c1<0)=0;  
    cost = w'*w+ lambda*(sum(c1));
    J=[J;cost]
    fprintf('Cost:%f\n',cost);
end