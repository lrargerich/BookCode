function g = Sigmoid(z)
    g = 1 ./ (1 + exp(-z));
end
