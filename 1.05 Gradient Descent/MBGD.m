function [theta, J_history,theta_history] = MBGD(X, y, alpha, num_iters,ComputeCost,ComputeGradient,batch_size,theta)
if ~exist('theta', 'var') 
    theta=rand(size(X,2)+1,1);
end
if ~exist('batch_size', 'var') 
    batch_size=size(X,1)/10;
end

X=[ones(size(X,1),1),X];
m = length(y);  
J_history = [];
theta_history = [];
for iter = 1:num_iters
  
  for i = 1:ceil((size(X,1)/batch_size))
    ini_rows = 1+((i-1)*batch_size);
    end_rows = ini_rows+batch_size-1;
    
    if end_rows>size(X,1)
        end_rows=size(X,1);
    end
   
    rows = X(ini_rows:end_rows,:);
    ys = y(ini_rows:end_rows,:);
    gradient = ComputeGradient(rows,ys,theta);
    theta = theta - alpha*gradient;
	cost = ComputeCost(X, y, theta);
    J_history = [J_history;cost];
    theta_history=[theta_history;theta'];
  end
  fprintf('Iter:%d Cost:%d\n',iter,cost);  
end
