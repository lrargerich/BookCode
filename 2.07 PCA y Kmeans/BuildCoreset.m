function x=BuildCoreset(x,pts)
[u,s,v]=svd(x);
d=s*v';
x=d(1:pts,:);
end

