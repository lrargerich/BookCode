function [C,alpha]=AdaSeq(X,Y)
[m,n]=size(X);
nboost=n; % One classifier for each feature in X
C=cell(nboost,1);
W=ones(m,1);
alpha=zeros(1,nboost);

for i=1:nboost
    fprintf('Training weak classifier for feature %d/%d\n',i,nboost);
    [split,sign]=SingleFeatureDecisionStump(X(:,i),Y,W);
    C{i}=[split,sign];
    yhat=Predict(X(:,i),split,sign);
    e=sum(W.*(Y~=yhat))/m;
    alpha(i)=.5*log((1-e)/max(e,eps));
    W=W.*exp(-alpha(i).*Y.*yhat);
    W=W/sum(W);
end

end
