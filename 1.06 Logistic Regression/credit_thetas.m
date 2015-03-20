load('credit.mat');

all=[credit,balance];
all=featureNormalize(all,0);

credit_o=all(:,1:10);
balance_o=all(:,11);
balance=balance_o;
credit=credit_o;

initial_theta=zeros(11,1);
best_theta=initial_theta;
j=[];
best_error=9999999999999999;
all_thetas=[];
for lambda=0.0:0.05:2
   % Randomizar datos
   % Optimize theta for train set
   options = optimset('GradObj', 'on', 'MaxIter', 5000);
   %[theta] = fmincg (@(t)(RegressionCostAndGradient(t, train, balance_train, lambda)), initial_theta, options);
   theta=NormalEquation(credit_o,balance_o,lambda);
   all_thetas=[all_thetas;theta'];
   % Now predict test set
   predict = test*theta;
   error = sum((predict-balance_test).^2)/320;
   if error<best_error
       best_error=error;
       best_theta=theta;
   end
   errors = errors+error;
   fprintf('For lambda = %d error is %f\n',lambda,errors/10);
   j=[j;(errors/10)];
end
all_thetas=all_thetas';

for i=2:10
    plot(0.0:0.05:2,all_thetas(i,:));
    hold on;
end
ylabel('Theta Value');
xlabel('lambda');
title('Theta Coefficients');
legend('income','limit','rating','cards','age','edu','sex','student','married','ethn');