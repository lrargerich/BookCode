function L=ComputeLaplacian(W,method)
if ~exist('method','var'), 
    method=1; 
end
D=diag(sum(W,2));
if method==1
    L = (D^(-1/2)) * ((D-W) * (D^(-1/2)));
elseif method==2
    L=(D^-1)-W;
else    
    L=D-W;
end
end

