function [y,Lij] = MDS(Dij,k,max_iter,alpha)
if ~exist('max_iter','var'), max_iter=10000; end
if ~exist('alpha','var'), alpha=0.0001; end
y = rand(size(Dij,1),k);

Lij = zeros(size(Dij,1),size(Dij,1));

for iter=1:max_iter
    % Update Lij
    error=sum(sum((Lij-Dij).^2));
    fprintf('(%i) alpha=%g error=%f\n',iter,alpha,error);
    for i=1:size(Dij,1)
        for j=1:size(Dij,1)
            if (i~=j)
                Lij(i,j) = norm(y(i,:)-y(j,:));
            end
        end
    end

    % Now I have to update each point
    for i=1:size(Dij,1)
        grad=zeros(1,k);
        for j=1:size(Dij,1)
            if (i~=j)
                %y(i,:) = y(i,:) - alpha * (Lij(i,j) - Dij(i,j)) * (y(i,:)-y(j,:));
                grad = grad+(Lij(i,j) - Dij(i,j)) * (y(i,:)-y(j,:));
            end   
        end
        y(i,:) = y(i,:) - alpha * grad;
    end
end
