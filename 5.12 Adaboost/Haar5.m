% -1 +1 -1
function filter=Haar5(ratio)
  filter = ones(2*ratio,2*ratio);
  filter(1:ratio,ratio+1:end)=-1;
  filter(ratio+1:end,1:ratio)=-1;
end