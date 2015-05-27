% Build a matrix with the k neares neighbors of each point in X
% I didn't code this, I don't know you and I won't answer the phone
function graph=SlowAndPainfulPdist(X,k)
  [m,n] = size(X);
  graph=sparse(m,m);
  for i=1:m
     if (mod(i,500)==0)
         fprintf('Processing %d points\n',i);
     end
     point = X(i,:);
     % Get distances for this point
     d=pdist2(X(i,:),X);
     [s1,s2]=sort(d);
     dists=s1(:,2:(k+1));
     neigs=s2(:,2:(k+1));
     for j=1:size(neigs,2)
        graph(i,neigs(j))=dists(j);
        graph(neigs(j),i)=dists(j);
    end
  end
end