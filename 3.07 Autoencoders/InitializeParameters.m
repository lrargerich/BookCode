function theta = initializeParameters(hiddenSize, visibleSize)
%% Initialize parameters randomly based on layer sizes.
r  = sqrt(6) / sqrt(hiddenSize+visibleSize+1);   % we'll choose weights uniformly from the interval [-r, r]
W1 = rand(hiddenSize, visibleSize) * 2 * r - r;
W2 = rand(visibleSize, hiddenSize) * 2 * r - r;
b1 = zeros(hiddenSize, 1);
b2 = zeros(visibleSize, 1);
theta = [W1(:) ; W2(:) ; b1(:) ; b2(:)];
end

