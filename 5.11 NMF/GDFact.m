function [P,Q] = GDFact(R,k,lambda1,lambda2,alpha,max_iter)

[m,n]=size(R);

P=rand(m,k);
Q=rand(k,n);

for iter=1:max_iter
    for x=1:m
        for i=1:n
            exi=R(x,i)-(P(x,:)*Q(:,i));
            P(x,:)=P(x,:)+alpha*(exi*P(x,:)-lambda1*P(x,:));
            Q(:,i)=Q(:,i)+alpha*(exi*Q(:,i)-lambda2*Q(:,i));
        end
    end
    error = sum(sum((R-(P*Q)).^2));
    fprintf('Iteration: %d/%d error=%f\n',iter,max_iter,error);
end

end