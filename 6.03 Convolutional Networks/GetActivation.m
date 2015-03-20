function [H, O] = GetActivation(model,X)
X=X';
H = bsxfun(@plus, model.theta_ih * X, model.b_ih);
H = Sigmoid(H);
O = bsxfun(@plus, model.theta_ho * H, model.b_ho);
O = Sigmoid(O);
end