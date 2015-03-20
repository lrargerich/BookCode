% -1 +1 -1
function filter=Haar3(ratio)
  filter = ones(ratio,3*ratio);
  filter(:,1:ratio)=-1;
  filter(:,(2*ratio)+1:end)=-1;
end