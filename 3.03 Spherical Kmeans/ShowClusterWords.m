function words = ShowClusterWords(centroids,cluster,wdic)
	vector=centroids(cluster,:);
	[sv,si] = sort(vector(:),'descend');
	words = wdic(si(1:20))';
end