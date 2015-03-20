function dsigm = SigmoidGradient(a)
dsigm = a .* (1.0 - a);
 
end
