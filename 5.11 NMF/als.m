function [A,X]=als(Y,J,maxiter);
i=0;
[m,n]=size(Y);
A=rand(m,J);
X=rand(J,n);
E=Y-A*X;
er=1e-5;

while 1 
    i=i+1; 
    fprintf('%d: %f \n',i,sqrt(sum(sum(E.^2)))); 
    if sqrt(sum(sum(E.^2))) < er || i > maxiter 
        break; 
    end
    At=(X*X'+ 1e-5*eye(J))*(X*Y');A=At'; 
    A(A < 0)=1e-16; 
    X=(A'*A + 1e-5*eye(J))*(A'*Y); X(X < 0)=1e-16; 
    E=Y-A*X;
end
end