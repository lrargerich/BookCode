%function b=normalize_norm_mean(a)
%[n dim]=size(a);
%for i=1:n
    %a(i,:)=(a(i,:)-mean(a(i,:)))/norm(a(i,:)-mean(a(i,:)),2);
%end
%b=a;

function X_norm = RowNormalize2(X,denoise)
	X = double(X);
	if ~exist('denoise','var'), denoise=10; end
	X_norm = X;
	%mu = mean(X);
	%varx = var(X);
	for j=1:size(X,1),
		xi = X(j,:);
  		X_norm(j,:) = ((X(j,:) - mean(X(j,:))) / (sqrt(var(X(j,:)) + denoise)));
	end;
end
