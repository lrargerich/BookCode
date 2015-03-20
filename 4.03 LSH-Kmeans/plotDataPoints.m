function PlotDataPoints(X, idx, K)
palette = hsv(K + 1);
colors = palette(idx, :);

% Plot the data
scatter(X(:,1), X(:,2), 35, colors, 'filled');

end
