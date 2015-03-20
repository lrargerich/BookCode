function PlotDataPoints(X, idx, K)
palette = hsv(K + 1);
colors = palette(idx, :);

scatter(X(:,1), X(:,2), 45, colors, 'filled');

end
