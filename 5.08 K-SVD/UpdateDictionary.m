%% D is a nxk dictionary and S is a kxm matrix
%% we return an updated dictionary 
function [D,S]=UpdateDictionary(X,D,S)
    k = size(D,2);
    n = size(D,1);
    m = size(S,2);
    X=X';  
    for j=1:k  % Update each column of D
        sj=S(j,:);
        indexes=1:k;
        indexes=indexes(indexes~=j); 
        % Now find from Sj which atoms use this column (w)
        w = find(sj~=0);
        if w
            % Take all the columns of D except j
            Dr = D(:,indexes);
            % Take all the rows of S except j
            Sr = S(indexes,w);
            % Multiply and substract from original 
            Ej = X(:,w)-(Dr*Sr);
            % Compute SVD
            [u,sigma,v]=svds(Ej,1);
            % The first column of u updates dj
            D(:,j)=u(:,1);
            % Take the first column of v 
            v1=v(:,1);
            % First singular value
            sigma1 = sigma(1,1);
            % Take the non zero elements of 
            S(j,w) = sigma1 * v1;
        end
    end
end