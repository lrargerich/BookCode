function [P,Q,RMSE] = GDMatrixFact(R,alpha,lambda_p,lambda_q,k,num_iters)
%R = double(R)/5.0;
[m,n] = size(R);
P = 0.5 * rand(m,k);
Q = 0.5 * rand(n,k);
new_P = P;
new_Q = Q;

count=2;    
for iter = 1:num_iters
   
    for i = 1:m
       ratedIndex1 = R(i,:)~=0 ;
       sumVec1 = ratedIndex1 .* (P(i,:) * Q' - R(i,:));
       product1 = sumVec1 * Q;
       derivative1 = product1 + lambda_p * P(i,:);
       new_P(i,:) = P(i,:) - alpha * derivative1;
    end
    
    for j = 1:n
       ratedIndex2 = R(:,j)~=0;
       sumVec2 = ratedIndex2 .* (P * Q(j,:)' - R(:,j));
       product2 = sumVec2' * P;
       derivative2 = product2 + lambda_q * Q(j,:);
       new_Q(j,:) = Q(j,:) - alpha * derivative2;
    end
    
    P = new_P;
    Q = new_Q;
    count = count + 1;
    
    error = sum(sum((R-(P*Q')).^2));
    fprintf('Iteration: %d/%d error=%f\n',iter,num_iters,error);
end
Q=Q';
end