function x=RBMReconstruct(y,W)
% add ones to y at the end multiply by W' voila!
y=[y,ones(size(y,1),1)];
x=double(Sigmoid(y*W')>0.5);
x=x(:,2:end);
end