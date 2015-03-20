function Spectral(x,k,sigma)
    [v,lambdas]=SpectralClusteringHelper(x,sigma);
    SpectralClusteringFig(x,v,lambdas,k);
end