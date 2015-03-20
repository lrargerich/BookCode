% +1
% -1
function filter=Haar2(ratio)
  filter = ones(2*ratio,ratio);
  filter(1:ratio,:)=-1;
end