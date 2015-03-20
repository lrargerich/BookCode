%Y must be the vector of labels in -1 +1 format
%X must be the data in m instances by n features
%W is a vector with weights for each point 
function [C,alpha]=Ada(X,Y,nboost)
[m,n]=size(X);
% The number of classifiers is nboost
C=cell(nboost,1);
W=ones(m,1);
alpha=zeros(1,nboost);

for i=1:nboost
    [split,sign,dim]=DecisionStump(X,Y,W);
    C{i}=[split,sign,dim];
    yhat=StumpPredict(X,split,sign,dim);
    e=sum(W.*(Y~=yhat))/m;
    alpha(i)=.5*log((1-e)/max(e,eps));
    W=W.*exp(-alpha(i).*Y.*yhat);
    W=W/sum(W);
end

end
