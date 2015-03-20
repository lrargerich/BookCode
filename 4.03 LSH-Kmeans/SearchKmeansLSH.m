function [items,s2]=KNNKmeansLSH(KLSH,x,num)
    % look closest centroid
    c=findClosestCentroids(x,KLSH.centroids);
    % now compare against points in that centroid
    candidates=find(KLSH.idx==c);
    % Compute distance to each candidate
    difs=bsxfun(@minus,x,KLSH.X(candidates,:));
    difs=sum(difs.^2,2);
    [s1,s2]=sort(difs);
    if length(s2>num)
        s2=s2(1:num);  
    end
    s2=candidates(s2,:);
    items=KLSH.X(s2,:);
end


