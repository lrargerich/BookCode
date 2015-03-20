% Create random matrix of 4 points with 50000 dimensions
x= rand(4,50000);
% Compute the projection matrix for 0.15 error
xp = JLProjectionHash(x,0.15);
size(xp)
% See if distances are preserved
IsPreserved(x,xp,0.15);