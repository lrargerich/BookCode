function [patches,ZCAWhite,meanPatch] = ZCAWhitening(patches,epsilon)
    % Subtract mean patch (hence zeroing the mean of the patches)
    patches=patches';
    meanPatch = mean(patches, 2); 
    numPatches=size(patches,2);
    patches = bsxfun(@minus, patches, meanPatch);
    % Apply ZCA whitening
    sigma = patches * patches' / numPatches;
    [u, s, v] = svd(sigma);
    ZCAWhite = u * diag(1 ./ sqrt(diag(s) + epsilon)) * u';
    patches = ZCAWhite * patches;
end    