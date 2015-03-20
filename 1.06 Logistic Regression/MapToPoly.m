function out = MapToPoly(X,degree)
if ~exist('degree','var')
    degree=2
end
out=[];
for i=1:size(X,1)
    x=X(i,:);
    aux=[];
    for z = 1:degree
        for w = 0:z
            aux = [aux,(x(1).^(z-w).*(x(2).^w))];
        end
    end
    out=[out;aux];
end
end