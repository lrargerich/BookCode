function VisualizeBoundary(theta, X, y,degree)

if ~exist('degree','var')
    degree=1;
end

X=[ones(size(X,1),1),X];
% Plot Data
plotData(X(:,2:3), y);
hold on

if size(X, 2) <= 3
    % Only need 2 points to define a line, so choose two endpoints
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    % Calculate the decision boundary line
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));

    % Plot, and adjust axes for better viewing
    plot(plot_x, plot_y)
    
    % Legend, specific for the exercise
    axis([min(X(:,2)),max(X(:,2)),min(X(:,3)),max(X(:,3))])
else
    % Here is the grid range
    u = linspace(min(X(:,2)),max(X(:,2)), 100);
    v = linspace(min(X(:,3)),max(X(:,3)), 100);

    z = zeros(length(u), length(v));
    % Evaluate z = theta*x over the grid
    for i = 1:length(u)
        for j = 1:length(v)
            poo = MapToPoly([u(i), v(j)],degree);
            poo = [1,poo];
            z(i,j) = poo*theta;
        end
    end
    z = z'; % important to transpose z before calling contour

    % Plot z = 0
    % Notice you need to specify the range [0, 0]
    contour(u, v, z, [0, 0], 'LineWidth', 2)
end
hold off

end
