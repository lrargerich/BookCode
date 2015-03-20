function y = ForgetronPredict(model,x)
total=0;
idx = find(model.err_mem~=0);
total=0;
for j=1:length(idx)
    errpt = model.err_mem(idx(j),:);
    k = model.kernel(x,errpt);
    total=total+(model.alpha*model.y_mem(idx(j))*model.err_mem(idx(j))*k);
end
if total>0
    y=1;
else
    y=-1;
end
end