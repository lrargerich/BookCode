%% Classifies point x using the k closest neighbors from points
%% and their labels
function [class,prob,neighbors,c]=KNNClassify(x,points,k,labels)
    [neighbors,c]=KNN(x,points,k,labels);
    class = mode(c);
    prob = sum(c==mode(c))/k;
end