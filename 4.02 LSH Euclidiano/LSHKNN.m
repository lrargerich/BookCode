%% This function searches for point x in the
%% given LSH structure and returns the k
%% nearest neighbors
function [neighbors,s2,indexes]=LSHKNN(LSH,x,k)
    or_set=[];
    for i=1:LSH.b
        and_set=[];     
        for j=1:LSH.r
            table=((i-1)*LSH.r)+1+(j-1);
            bucket=1+floor(dot(x,LSH.pro(table,:))/LSH.w);
            return_set=LSH.table{table}{bucket};
            if j==1
                and_set=return_set;
            else
                and_set=intersect(and_set,return_set);
            end
        end
        % and_set might be empty life is hard
        or_set=union(or_set,and_set);
    end
    my_points=LSH.X(or_set,:);
    card = min([k,size(or_set,1)]);
    % Compute distance from x to each point
    z=sum(bsxfun(@minus,x,my_points).^2,2);
    [s1,s2]=sort(z,'ascend');
    indexes=or_set(s2(1:(card)));
    neighbors=LSH.X(indexes,:);

end