function theta = rbm(X,hidden_units,theta,alpha,epochs)
	% Add Bias to samples
	m = size(X,1);
	X = [ones(m,1), X];

	for z = 1:epochs
		m = size(X,1);
		features = size(X,2);

		for i = 1:m
			sample = X(i,:);
		
			%fprintf('Sample... \n');
			%sample
			
			% Set the activation of each hidden_unit
			activation = sigmoid(sample * theta');
			for j = 1:hidden_units+1
				roll = rand(1,1);
				if roll<activation(j)
					activation(j) = 1;
				else
					activation(j) = 0;
				endif
			end
			% Bias Unit is always activated
			activation(hidden_units+1)=1;
			% After this we have in activation 1 or 0 for each hidden unit
			
			%fprintf('Hidden Units... \n');
			%activation
			
			% Now compute epos
			epos = sample' * activation;
			
			%fprintf('epos... \n');
			%epos
			
			% Now rebuild visible units using theta (weights) and the hidden_units
			visible = sigmoid(activation * theta);
			for j = 1:features
				roll = rand(1,1);
				if roll<visible(j)
					visible(j) = 1;
				else
					visible(j) = 0;
                end
			end
			
			%fprintf('Visible again... \n');
			%visible
			
			% Now we update the hidden units again!
			activation = sigmoid(visible * theta');
			for j = 1:hidden_units+1
				roll = rand(1,1);
				if roll<activation(j)
					activation(j) = 1;
				else
					activation(j) = 0;
				endif
			end
			activation(hidden_units+1)=1;
			
			%fprintf('Hidden Units Again... \n');
			%activation
			
			% Now compute eneg
			eneg = visible' * activation;
			
			%fprintf('eneg... \n');
			%eneg
			
			% update weights
			theta = theta + (alpha*(epos - eneg))';
			
			%fprintf('theta... \n');
			%theta

		end
            end
            end
        end
    end
end