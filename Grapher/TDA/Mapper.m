%% Creates a Topological Data Analysis (TDA) of X
%% X is a m x n matrix with m observations in n dimensions
%% (observations are rows)
%% res is the resolution to apply
%% overlap is the overlap when clustering
%% buckets is the coefficient for clustering cutoff
%% This 3 parameters must be grid-searched or experimented try with a smaller
%% dataset first, find the parameters then increase the dataset size.
%% lens is a function that takes X as argument and returns a vector of m real 
%% numbers.
%% This function returns a TDA object with a graph
%% The number of nodes, edges and shape of the graph will determine if you
%% should change the parameters.
function TDA=Mapper(X,res,overlap,buckets,lens,labels) 
  [m,n] = size(X);
  matrix=X;
  fprintf('Mapping a dataset with %d observations in %d dimensions using resolution=%d overlap=%f buckets=%f\n',m,n,res,overlap,buckets);
  %% Apply the filter
  X = lens(X);
  TDA.done=1;
  %% Segment by resolution
  l=FindSegment(max(X)-min(X),res,overlap);
  cluster_index=1;
  bottom = min(X);
  for i = 1:res
    top = bottom+l;
    points=matrix(X>=bottom & X<=top,:); 
    which_points = find(X>=bottom&X<top);
    % Now if we have points we have to cluster them
    if size(points,1)>2
        fprintf('Clustering %d points\n',size(points,1));
        %scatter(matrix(:,1),matrix(:,2),4,repmat(1,size(matrix,1),1),'filled');
        %hold on;
        %scatter(matrix(which_points,1),matrix(which_points,2),4,repmat(2,size(which_points,1),1),'filled');
        % Here apply clustering to the points
        D=pdist(points);
        z=linkage(D,'single');    
        C=z(:,3);
        %fprintf('C is a vector with %d different values\n',size(C,1));
        % Discretizice C and find gaps
        range=max(C)-min(C);
        ll=linspace(min(C),max(C),buckets);
        bins=discretize(C,ll);   
        % Now find a gap of 1 or 2 empty bins to cut the clustering
        first_gap = min(setdiff(min(bins):max(bins),unique(bins)));
        if isempty(first_gap)
            first_gap=9032;
        end
        % Cut the clustering 
        gap_position=size(z(bins<first_gap,:),1);
        num_clusters=size(points,1)-gap_position;
        if num_clusters==0
            num_clusters=1;
        end
        fprintf('First gap cuts this to %d clusters\n',num_clusters);
        idx=cluster(z,'maxclust',num_clusters);
        which_points = find(X>=bottom&X<=top);
        for clus_num=min(idx):max(idx)
            if size(which_points(idx==clus_num),1)>0
                clusters{cluster_index}=which_points(idx==clus_num);               
                lens_averages{cluster_index}=mean(X(which_points));
                if exist('labels','var')
                    label_averages{cluster_index}=mean(labels(which_points));
                end
                cluster_index=cluster_index+1;
            end
        end
    end
    bottom=bottom+(l*(1-overlap));
  end 
  fprintf('Total Number of clusters=%d\n',cluster_index-1);
  TDA.clusters=clusters;
  [nr,nc]=cellfun(@size,TDA.clusters);
  TDA.cluster_sizes=nr;
  TDA.points=m;
  TDA.adj=LinkClusters(TDA);
  node_table=[1:size(TDA.clusters,2);nr]';
  node_table=[node_table,cell2mat(lens_averages)'];
  if exist('labels','var')
      TDA.label_averages=round(cell2mat(label_averages))';
      node_table=[node_table,round(cell2mat(label_averages))'];
  end
  
  TDA.node_table = node_table;
  
  
  [r,c]   = find(TDA.adj~=0);
  v       = nonzeros(TDA.adj);
  compact = [r,c,v];
  
  TDA.edges_table=compact;
end