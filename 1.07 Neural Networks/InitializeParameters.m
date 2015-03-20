function theta = InitializeParameters(visibleSize,hiddenSize,outputSize)
%% Initialize parameters randomly based on layer sizes.
r  = sqrt(6) / sqrt(hiddenSize+visibleSize+1);   % we'll choose weights uniformly from the interval [-r, r]
W1 = rand(hiddenSize, visibleSize) * 2 * r - r;
W2 = rand(outputSize, hiddenSize) * 2 * r - r;
b1 = zeros(hiddenSize, 1);
b2 = zeros(outputSize, 1);
theta = [W1(:) ; W2(:) ; b1(:) ; b2(:)];
end

