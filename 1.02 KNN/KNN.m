%% Finds the k closests points to x from points and their labels if passed
function [neighbors,classes] = KNN(x,points,k,labels)
    z=sum(bsxfun(@minus,x,points).^2,2);
    [s1,s2]=sort(z,'ascend');
    neighbors=points(s2(1:(k)),:);
    if exist('labels','var')
        classes = labels(s2(1:(k)));
    end
end