function [centroids,idx,J] = AnimatedOnlineKmeans(X,k,iter)
	% loop each point
   	if ~exist('iter','var'), iter=1; end
	idx=zeros(size(X,1),1);
    J=[];
	centroids = X(1+floor(rand(k,1)*size(X,1)),:);
	counts = zeros(1,k);
    for j=1:iter 
        fprintf('Iteration: %d\n',j);
        for i=1:size(X,1)
            % find closest centroid to X
            position = FindClosestCentroids(X(i,:), centroids);            
            old_position=idx(i);
            if old_position~=0
                % Remove it from old cluster
                counts(old_position)=counts(old_position)-1;
            end
            % Assign to new cluster
            idx(i)=position;
            counts(position) = counts(position) + 1;
            centroids(position,:) = centroids(position,:) + (1/counts(position)) * (X(i,:) - centroids(position,:));     
        end
        cost = ComputeKmeansCost(X,centroids,idx); 
        figure(1);
        clf
        PlotDataPoints(X,idx,k);
        pause(0.5);
        J=[J;cost];
    end
end