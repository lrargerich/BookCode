function p = NNPredict(model, X)
m = size(X, 1);
theta_ih = model.theta_ih;
theta_ho = model.theta_ho;
num_labels = size(theta_ho, 1);
h1 = Sigmoid([ones(m, 1) X] * theta_ih');
h2 = Sigmoid([ones(m, 1) h1] * theta_ho');
[dummy, p] = max(h2, [], 2);
end
