function y=RBMRepresent(x,W)
%Add ones to x multiply by W voila!
x=[ones(size(x,1),1),x];  
y=double(Sigmoid(x*W)>0.5);
y=y(:,1:(size(y,2)-1));
end