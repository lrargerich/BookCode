function [W,J] = LearnBinaryRBMb(X,dims,iter,alpha,epochs,weight,minibatch,W)
    if ~exist('alpha','var'), alpha=0.01; end
    if ~exist('weight','var'), weight=0.5; end
    if ~exist('iter','var'), iter=100; end
    if ~exist('minibatch','var'), minibatch=100; end
     
    X=[ones(size(X,1),1),X];
    m = size(X,1);
    n = size(X,2);
    J=[];

    if ~exist('W','var'),W = rand(n,dims+1); end
    
    for epoch=1:epochs
       errors=0;
       for i=1:minibatch:m  
            size(X,1)-i;
            last=min([size(X,1),i+minibatch-1]);
            batch=last-i+1;
            input = X(i:last,:);
            original_input=input;
            y = double(Sigmoid(input*W)>rand(batch,dims+1));
            y(:,dims+1)=1;
           
            Epos = (input'*y)./batch;
            
            for it=1:iter
                input=double(Sigmoid(y*W')>rand(batch,n));
                input(:,1)=1;
                y = double(Sigmoid(input*W)>rand(batch,dims+1));
                y(:,dims+1)=1;
            end
            
            error=sum(sum((input-original_input).^2));
            errors=errors+error;
            
            Eneg = (input'*y)./batch;
            
            W = weight*(W+alpha*(Epos-Eneg)) + ((1-weight)*W);
       end  
       J=[J;errors/m];
       fprintf('Epoch %d Average error=%f\n',epoch,errors/m);
    end
end