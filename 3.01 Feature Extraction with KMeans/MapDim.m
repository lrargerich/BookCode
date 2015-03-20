function y = MapDim(x,gamma)
  if ~exist('gamma','var'), gamma=0.5; end
  y = exp(gamma * -x);
end