%% Finds the k closests points to x from points and their labels if passed
function [neighbors,classes,distances,indexes] = KNN(x,points,k,labels)
    classes=[];
    z=sum(bsxfun(@minus,x,points).^2,2);
    [s1,s2]=sort(z,'ascend');
    indexes = s2(2:(k+1));
    neighbors=points(indexes,:);
    distances=s1(2:(k+1));
    if exist('labels','var')
        classes = labels(s2(2:(k+1)));
    end
end