function best_idx=SpectralGridSearch(x,k,sigmas)
min_cost=-2;
for i=1:length(sigmas)
    sigma=sigmas(i);
    for j=1:3
        [v,lambdas]=ComputeSpectrum(x,sigma,j);
        for z=1:6
            v12=v(:,1:z); 
            [cen,idx]=Kmeans(v12,k,50);
            cen=computeCentroids(x,idx,k);
            cost=Silhouette(x,idx);
            fprintf('Sigma =%f Laplacian Method= %d EigenVectors: %d Cost: %f\n',sigma,j,z,cost);
            if cost>min_cost
                min_cost=cost;
                best_sigma=sigma;
                best_method=j;
                best_eigen=z;
                best_idx=idx;
            end
        end
    end
end
fprintf('Best Sigma =%f Best Laplacian Method= %d Best EigenVectors: %d Best Cost: %f\n',best_sigma,best_method,best_eigen,min_cost);
end
