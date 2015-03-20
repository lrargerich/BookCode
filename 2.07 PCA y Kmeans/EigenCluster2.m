%% This will cluster x in exactly two clusters
function idx=EigenCluster2(x)
mu=mean(x);
x=bsxfun(@minus,x,mu);
[u,s,v]=svd(x);
u=u(:,1);
idx=u>0;
idx=idx+1;
end

