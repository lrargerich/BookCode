function [C, sigma,j_plot,param_matrix] = GridSearchSVM(X, y, Xval, yval)
error_min = 10^9;

%cvect = [0.1; 0.5; 1; 3; 10; 100];
%svect = [0.01; 0.03; 0.1; 0.5;  1];
cvect = linspace(0.1,5,10);
svect = linspace(0.03,0.08,10);

param_matrix=zeros(length(cvect),length(svect));

j_plot=[];

for i = 1:length(cvect)
	%C=C*1.1;
    j_aux=[];
	for j = 1:length(svect)
		C = cvect(i);
		sigma = svect(j);
		model= SMOSVMTrain(X, y, C, @(x1, x2) GaussianKernel(x1, x2, sigma));
		pred = SMOSVMPredict(model,Xval);
		error = mean(double(pred~=yval));
		if error < error_min
			error_min = error;
			retC = C;
			retSigma = sigma;
        end
        j_aux=[j_aux,error];
        param_matrix(i,j)=error;
        fprintf('C=%f Sigma=%f error=%f\n',C,sigma,error);
		%sigma = sigma * 1.1;
	end
	j_plot=[j_plot;j_aux];
end
figure;
for i = 1:length(cvect)
    plot(svect,j_plot(i,:));
    hold on;
end
legends=cell(1,length(cvect));
for i = 1:length(cvect)
    s=sprintf('C=%f',cvect(i));
    legends{i}=s;
end
legend(legends);
ylabel('Error');
xlabel('Sigma');
title('SVM Tune');
C = retC
sigma = retSigma
end
