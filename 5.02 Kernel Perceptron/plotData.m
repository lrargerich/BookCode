function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

good = find(y==1);  % y=1 indices
bad = find(y==0); % y =0 indices

plot(X(good,1),X(good,2),'k+','Linewidth',2,'MarkerSize',7);
plot(X(bad,1),X(bad,2),'ko','MarkerFaceColor','y','MarkerSize',7);








% =========================================================================



hold off;

end
