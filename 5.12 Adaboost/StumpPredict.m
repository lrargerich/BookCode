function labels=StumpPredict(X,split,sign,dim)
    labels=ones(size(X,1),1);
    labels(find(X(:,dim)<=split))=-1;
    labels=labels*sign;
end