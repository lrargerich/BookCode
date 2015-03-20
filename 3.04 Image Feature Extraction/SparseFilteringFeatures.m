function Fhat = SparseFilteringFeatures(W,X)
X=X';
F = W*X; % Linear Activation
Fs = sqrt(F.^2 + 1e-8); % Soft-Absolute Activation
[NFs, L2Fs] = l2row(Fs); % Normalize by Rows
[Fhat, L2Fn] = l2row(NFs'); % Normalize by Columns
end

function [Y,N] = l2row(X) % L2 Normalize X by rows
% We also use this to normalize by column with l2row(X')
N = sqrt(sum(X.^2,2) + 1e-8);
Y = bsxfun(@rdivide,X,N);
end