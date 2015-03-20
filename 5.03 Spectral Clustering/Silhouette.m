function [s,silhouettes]=Silhouette(x,idx)
    % compute all distances
    dist = pdist2(x,x);
    silhouettes=zeros(size(x,1),1);
    for i=1:size(x,1)
       my_cluster=idx(i);
       neighbors = find(idx==my_cluster);
       if isempty(neighbors)
           ai=0
       else
        ai=mean(dist(i,neighbors));
       end
       not_neighbors = find(idx~=my_cluster);
       if isempty(not_neighbors)
        bi=0
       else
        bi=min(dist(i,not_neighbors));
       end
       if bi+ai~=0
        si = (bi-ai)/max([bi,ai]);
       else
        si=0
       end
       silhouettes(i)=si;
    end
    s=mean(silhouettes);
end