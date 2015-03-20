function VisualizeBoundary(model, X, y)

X=[ones(size(X,1),1),X];
plotData(X(:,2:3), (y+1)/2);
hold on

% Here is the grid range
u = linspace(min(X(:,2)),max(X(:,2)), 200);
v = linspace(min(X(:,3)),max(X(:,3)), 200);

z = zeros(length(u), length(v));

for i = 1:length(u)
    for j = 1:length(v)
        z(i,j)=KernelPredict(model,[u(i),v(j)]);
    end
end

z = z'; % important to transpose z before calling contour
% Plot z = 0
% Notice you need to specify the range [0, 0]
contour(u, v, z, [0, 0], 'LineWidth', 2)
hold off
end
