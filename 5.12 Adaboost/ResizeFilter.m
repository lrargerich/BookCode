% -1 +1
function filter=Haar1(ratio)
  filter = ones(ratio,2*ratio);
  filter(:,1:ratio)=-1
end