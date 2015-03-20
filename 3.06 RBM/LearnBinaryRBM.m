function [W,J] = LearnBinaryRBM(X,dims,iter,alpha,epochs,weight,W)
    if ~exist('alpha','var'), alpha=0.01; end
    if ~exist('weight','var'), weight=0.5; end
    if ~exist('iter','var'), iter=100; end
    
    X=[ones(size(X,1),1),X];
    m = size(X,1);
    n = size(X,2);
    if ~exist('W','var')
        W = rand(n,dims+1);
    end
    J=[];
    for epoch=1:epochs
       errors=0;
       for i=1:m     
            input = X(i,:);
            original_input=input;
            y = double(Sigmoid(input*W)>rand(1,dims+1));
            %y = Sigmoid(input*W);
            %r = rand(1,dims+1);
            %y = double(y>r);
            y(dims+1)=1;
            Epos = input'*y;
            for it=1:iter
                input=double(Sigmoid(y*W')>rand(1,n));
                input(1)=1;
                %input=Sigmoid(y*W');
                %r=rand(1,n);
                %input=double(input>r);
                y = double(Sigmoid(input*W)>rand(1,dims+1));
                %y=Sigmoid(input*W);
                %r=rand(1,dims+1);
                %y=double(y>r);  
                y(dims+1)=1;
            end
            error=sum((input-original_input).^2);
            errors=errors+error;
            Eneg = input'*y;
            W = weight*(W+alpha*(Epos-Eneg)) + ((1-weight)*W);
       end  
       J=[J;errors/m];
       fprintf('Epoch %d Average error=%f\n',epoch,errors/m);
    end
end