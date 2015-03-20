function [centroids,clusters] = OnlineFuzzyKmeans(X,k,iterations)
	[n,d] = size(X);
	clusters = rand(n,k);
	error = 1;
	iter = 0;
    maxi=max(X);
    mini=min(X);
    range=maxi-mini;
	centroids = bsxfun(@times,rand(k,d),range);
    centroids = bsxfun(@plus,centroids,mini);    
    clusters=zeros(size(X,1),k);
	for ii=1:iterations
        num_points=zeros(1,k);
        for i=1:size(X,1)
            x=X(i,:);
            % Compute cluster assignments for a single point
            clusters(i,:) = FuzzyComputeClusters(x,centroids);
            
            num_points = num_points+clusters(i,:);
            
            % Recompute centroids bringing it closer to the current point
            for j=1:k
               this_centroid=centroids(j,:);
               % take a centroid centroids(j,:)              
               difference=x-this_centroid;
               % Scale based on the probability of assignment
               difference = clusters(i,j)*difference;
               % Scale based on total assignment
               scaling = clusters(i,j)./num_points(j);
               difference = difference*scaling;
               centroids(j,:)=this_centroid+difference;
            end
           
        end
	end
end
