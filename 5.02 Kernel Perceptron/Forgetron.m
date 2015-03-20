function model = Forgetron(X,y,alpha,iter,kernel,max_memory,model)

if ~exist('model','var'), 
    % Initialize all memory vars
    y_mem = zeros(max_memory,1);
    x_mem = sparse(max_memory,size(X,2)+1);
    err_mem = zeros(max_memory,1);
    idx_mem = zeros(max_memory,1);
    timestamp_mem = zeros(max_memory,1);
    timestamp=0;
else
    y_mem = model.y_mem;
    x_mem = model.x_mem;
    idx_mem = model.idx_mem;
    err_mem = model.err_mem;
    timestamp_mem = model.timestamp_mem;
    timestamp=model.timestamp;
end

X=[ones(size(X,1),1),X];

for ii=1:iter
    errors=0;
    for i=1:size(X,1)
        timestamp=timestamp+1;
        x = X(i,:);
        idx = find(err_mem~=0);
        total=0;
        for j=1:length(idx)
            errpt = x_mem(idx(j),:);
            k = kernel(x,errpt);
            total=total+(alpha*y_mem(idx(j))*err_mem(idx(j))*k);
        end
        if sign(total)~=y(i)
           errors=errors+1;
           where=find(idx_mem==i);
           if where
              err_mem(where)=err_mem(where)+1;                
           else
           % Remove oldest item
           [mini,position] = min(timestamp_mem);         
           % Add current item
           idx_mem(position)=i;
           err_mem(position)=1;
           x_mem(position,:)=x;
           y_mem(position)=y(i);
           timestamp_mem(position) = timestamp;       
           end
        end
    end
    fprintf('Iteration:%d errors:%d points in memory:%d\n',ii,errors,sum(err_mem~=0));
    if errors==0
      break;
    end
end

model.kernel=kernel;
model.err_mem=err_mem;
model.x_mem=x_mem;
model.alpha=alpha;
model.idx_mem=idx_mem;
model.y_mem=y_mem;
model.timestamp_mem=timestamp_mem;
model.timestamp=timestamp;

end