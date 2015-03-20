function i=GuessRedux(X,energy)
if ~exist('energy','var'), energy=0.99; end
[u,e,v]=svd(X);
eigenval=sort(diag(e),'descend');
total_energy=sum(eigenval.^2);
for i=1:size(e,1)
    amount=sum(eigenval(1:i).^2);
    percent = amount/total_energy;
    if percent>energy
        break
    end
end
end