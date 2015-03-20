function pred = SMOSVMPredict2(model, X)

% Dataset 
m = size(X, 1);
p = zeros(m, 1);
pred = zeros(m, 1);

matrix=zeros(size(X,1),size(model.X,1));
for ii=1:size(X,1)
    for jj=1:size(model.X,1)
        matrix(ii,jj)=model.kernelFunction(X(ii,:),model.X(jj,:));
    end
end
alfi=repmat(model.alphas,1,size(X,1));
alfi=alfi';
matrix=matrix.*alfi;
alfi=repmat(model.y,1,size(X,1));
alfi=alfi';
matrix=matrix.*alfi;
matrix=sum(matrix,2);
% Convert predictions into 0 / 1
pred(matrix >= 0) =  1;
pred(matrix <  0) =  0;
end

