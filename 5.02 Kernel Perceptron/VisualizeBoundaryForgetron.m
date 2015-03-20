function VisualizeBoundaryForgetron(model, X, y)

X=[ones(size(X,1),1),X];
plotData(X(:,2:3), (y+1)/2);
hold on
for i=1:size(X,1)
    x=X(i,:);
    idx = find(model.err_mem~=0);
    total=0;
    model.timestamp=model.timestamp+1;
    for j=1:length(idx)
        errpt = model.x_mem(idx(j),:);
        k = model.kernel(x,errpt);
        total=total+(model.alpha*model.y_mem(idx(j))*model.err_mem(idx(j))*k);
    end
    %z(x(:,2),x(:,3)) = sign(total);
    if sign(total)~=y(i)
       % plot wrong
       plot(x(:,2),x(:,3),'rx','Markersize',12)
       where=find(model.idx_mem==i);
       if where
           model.err_mem(where)=model.err_mem(where)+1;                
       else
           % Remove oldest item
           [mini,position] = min(model.timestamp_mem);         
           % Add current item
           model.idx_mem(position)=i;
           model.err_mem(position)=1;
           model.x_mem(position,:)=x;
           model.y_mem(position)=y(i);
           model.timestamp_mem(position) = model.timestamp;       
        end
    else
       % plot right 
       %plot(x(:,2),x(:,3),'ob','Markersize',12)
    end
end
hold off
end
