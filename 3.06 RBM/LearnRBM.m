function W = LearnRBM(X,dims,iter,alpha,epochs,sigma_i,sigma_o)
    if ~exist('alpha','var'), alpha=0.1; end
    X=[ones(size(X,1),1),X];
    m = size(X,1);
    n = size(X,2);
    W = rand(n,dims+1);
    for epoch=1:epochs
       fprintf('Training epoch %d/%d\n',epoch,epochs);     
       Epos = zeros(n,dims+1);
       Eneg = zeros(n,dims+1);
       for i=1:m
            input = X(i,:);
            y = Sigmoid(input*W+randnorm(size(input,1),size(W,2),0,sigma_i));
            y(dims+1)=1;
            Epos = Epos+(input'*y);
            for it=1:iter
                input=Sigmoid(y*W'+randnorm(size(y,1),size(W,1),0,sigma_o));
                y=Sigmoid(input*W+randnorm(size(input,1),size(W,2),0,sigma_i));
                r=rand(1,dims+1);
                y=double(y>r);  
                y(dims+1)=1;
            end
            Eneg = (Eneg+input'*y);  
       end  
       Epos = Epos./m;
       Eneg = Eneg./m;
       W = W+alpha*(Epos-Eneg);
    end
end