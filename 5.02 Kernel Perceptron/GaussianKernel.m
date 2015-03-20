function sim = GaussianKernel(x1, x2, sigma)
sim = exp(-(sum((x1-x2).^2)/(2*sigma^2))); 
end
