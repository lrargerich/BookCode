function y = GeneralPredict(model,x)
total=0;
idx = find(model.err~=0);
for k=1:length(idx)
    errpt = model.error_points(idx(k),:);
    value = dot([1,x],errpt);
    total=total+(model.alpha*model.y(idx(k))*model.err(idx(k))*value);
end
if total>0
    y=1;
else
    y=-1;
end
end