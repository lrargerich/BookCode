function [W,H]=NFMMult(A,k,maxiter,W,H)
[m,n]=size(A);
if ~exist('maxiter','var')
    maxiter=10;
end
if ~exist('W','var')
W=rand(m,k);
H=rand(k,n);   
end
J=[];
for i=1:maxiter
  H=((W'*W)^-1)*W'*A;
  H(H<0)=0;
  Wt=((H*H')^-1)*H*A';W=Wt';
  W(W<0)=0;
  error = sum(sum((A-W*H).^2));  
  J=[J;error];
  fprintf('Iteration: %d Error:%f\n',i,error);
end
error = sum(sum((A-W*H).^2));
figure;
plot(J);
fprintf('Error: %d\n',error);
end