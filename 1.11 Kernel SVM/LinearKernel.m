function sim = LinearKernel(x1, x2)
x1 = x1(:); x2 = x2(:);
sim = x1' * x2;  % dot product
end