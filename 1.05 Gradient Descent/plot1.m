theta0_vals = linspace(-20, 10, 400);
theta1_vals = linspace(-2, 4, 400);
xold=X;
X=[ones(size(x,1),1),x];

J_vals = zeros(length(theta0_vals), length(theta1_vals));
% Fill out J_vals
for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
	  t = [theta0_vals(i); theta1_vals(j)];    
	  J_vals(i,j) = ComputeCost(X, y, t);
    end
end
contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 3, 50))
hold on
plot([theta_history(1:(size(theta_history)-1),1) theta_history(2:(size(theta_history)),1)],[theta_history(1:(size(theta_history)-1),2) theta_history(2:(size(theta_history)),2)],'k');
%scatter(theta_history(:,1),theta_history(:,2),[1],'filled')
%for i=1:(size(theta_history)-1)
%   plot([theta_history(i,1) theta_history(i+1,1)],[theta_history(i,2) theta_history(i+1,2)],'k'); 
%end

% Because of the way meshgrids work in the surf command, we need to 
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals';
% Surface plot
%figure;
%surf(theta0_vals, theta1_vals, J_vals)
%xlabel('\theta_0'); ylabel('\theta_1');

% Contour plot
%figure;
% Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
%contour(theta0_vals, theta1_vals, J_vals)
%xlabel('\theta_0'); ylabel('\theta_1');
%hold on;
%plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);

X=xold;