function ShowVoronoi(X,cen,idx)
    mini=min(X);
    maxi=max(X);
    range=maxi-mini;
    points=rand(100000,size(X,2));
    points=bsxfun(@times,points,range);
    points=bsxfun(@plus,points,mini);
    idx2=FindClosestCentroids2(points,cen);
    scatter(points(:,1),points(:,2),22,idx2+1,'filled')
    hold on
    scatter(X(:,1),X(:,2),32,'k')
    colormap(jet);
end