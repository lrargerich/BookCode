function labels=Predict(X,split,sign)
    labels=ones(size(X,1),1);
    labels(find(X<=split))=-1;
    labels=labels*sign;
end