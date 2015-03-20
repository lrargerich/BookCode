% -1 
% +1 
% -1
function filter=Haar4(ratio)
  filter = ones(3*ratio,ratio);
  filter(1:ratio,:)=-1;
  filter((2*ratio)+1:end,:)=-1;
end