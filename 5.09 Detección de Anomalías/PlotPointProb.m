function p1=PlotPointProb(X,threshold)
    if ~exist('threshold','var')
        threshold=1;
    end
    p1 = PointProbability(X); 
    p = floor(100*Scale(p1));
    figure
    scatter(X(:,1),X(:,2),42,p,'filled');
    colormap(hot)
    hold on;
    outliers = p1<threshold;
    out = X(outliers,:);
    plot(out(:,1),out(:,2),'ro','MarkerSize',10);
end