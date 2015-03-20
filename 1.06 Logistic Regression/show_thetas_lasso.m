all_thetas=allthetas';
for i=2:10
    plot(1:12267,all_thetas(i,:));
    hold on;
end
ylabel('Theta Value');
xlabel('Iteration');
title('LASSO Theta Coefficients');
legend('income','limit','rating','cards','age','edu','sex','student','married','ethn');