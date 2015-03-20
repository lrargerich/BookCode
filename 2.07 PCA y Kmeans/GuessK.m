function [i,eigenval]=GuessK(X,energy)
if ~exist('energy','var'), energy=0.95; end
mu=mean(X);
y=bsxfun(@minus,X,mu);
covm=y'*y;
[v,e]=eig(covm);
eigenval=sort(diag(e),'descend');
total_energy=sum(eigenval.^2);
for i=1:size(covm,1)
    amount=sum(eigenval(1:i).^2);
    percent = amount/total_energy;
    if percent>energy
        break
    end
end
end