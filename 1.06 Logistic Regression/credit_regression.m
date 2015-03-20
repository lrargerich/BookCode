load('credit.mat');
all=[credit,balance];
all=featureNormalize(all,0);
credit_o=all(:,1:10);
balance_o=all(:,11);
balance=balance_o;
credit=credit_o;
rounds=100;
initial_theta=zeros(11,1);
best_theta=initial_theta;
lambdas=[0 0.25 0.5 0.75 1 1.25 1.5 1.75 2 2.5 3 ];
j=[];
best_error=9999999999999999;
errors=zeros(length(lambdas),1);
for jj=1:rounds
   fprintf('Round %d of %d\n',jj,rounds);
   rp = randperm(400);
   balance=balance_o(rp,:);
   credit=credit_o(rp,:);
   credit_n1=credit;
   train = credit_n1(1:320,:);
   test = credit_n1(321:end,:);
   balance_train = balance(1:320,:);
   balance_test = balance(321:end,:);
   test=[ones(80,1),test];
   for i=1:length(lambdas)
       lambda = lambdas(i); 
       theta=NormalEquation(train,balance_train,lambda);
       predict = test*theta;
       error = sum((predict-balance_test).^2)/320;
       if error<best_error
           best_error=error;
           best_theta=theta;
       end
       errors(i) = errors(i)+error;
   end
end
errors=errors./rounds;
figure;
plot(lambdas,errors);
xlabel('lambda');
ylabel('error');
title('Credit Regression');