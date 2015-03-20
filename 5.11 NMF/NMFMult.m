function [W,H]=NMFMult(A,k,maxiter,W,H)
[m,n]=size(A);
if ~exist('maxiter','var')
    maxiter=10;
end
if ~exist('W','var')
W=rand(m,k);
H=rand(k,n);   
end
for i=1:maxiter
  H=H.*(W'*A)./(W'*W*H+10e-9);
  W=W.*(A*H')./(W*H*H'+10e-9);
  error = sum(sum((A-W*H).^2));
  fprintf('Iteration: %d Error:%f\n',i,error);
end
end