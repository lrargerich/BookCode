%% This function will represent point x (nx1) as a sparse linear combination of
%% the dictionary D (nxk) the result is a kx1 vector with t elements different 
%% than zero.
function s = MatchingPursuitPoint(x,D,tol)
if ~exist('tol','var')
    tol=0.05;
end
n=size(x,1);
k=size(D,2);
% The residual
r = x;
% The sparse representation
s = zeros(k,1);

while norm(r)>tol
   [maxval,j]=max(r'*D) 
   s(j) = s(j) + maxval;
   r = r - maxval*(D(:,j));
end
end