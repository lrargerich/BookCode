function PlotPointProb(X)
    p = floor(100*PointProbability(X));
    figure
    scatter(X(:,1),X(:,2),42,p,'filled');
end