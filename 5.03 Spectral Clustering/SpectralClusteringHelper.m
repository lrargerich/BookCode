function [v,lambdas]=SpectralClusteringHelper(x,sigma)
W=ComputeW(x,sigma);
figure;
imagesc(W);
title('Affinity Matrix');
L=ComputeLaplacian(W);
[v,lambdas]=eig(L);
lambdas=diag(lambdas);
[lambdas,lambdas_order]=sort(lambdas);
v=v(lambdas_order,:);
v=normalizeVector(v);
figure;
scatter(1:20,lambdas(1:20),'filled');
title('Eigenvalues');
figure;
for i=1:9
    subplot(3,3,i),plot(v(:,i))
    s=sprintf('v%d',i);
    title(s)
end
end

