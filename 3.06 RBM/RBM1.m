function theta = RBM1(X,hidden_units,alpha,epochs)
	m = size(X,1);
	X = [ones(m,1), X];
    theta=rand(hidden_units+1,size(X,2));
    
    for z = 1:epochs
        m = size(X,1);
		features = size(X,2);
        for i = 1:m
			sample = X(i,:);
            activation = Sigmoid(sample * theta');
            roll=rand(1,hidden_units+1);
            activation=double(activation>roll);
            activation(hidden_units+1)=1;
            epos = sample' * activation;
            visible = Sigmoid(activation * theta);
            roll=rand(1,features);
            visible=double(visible>roll);
            % Now we update the hidden units again!
			activation = Sigmoid(visible * theta');
            roll=rand(1,hidden_units+1);
            activation=double(activation>roll);
			activation(hidden_units+1)=1;
            eneg = visible' * activation;
			% update weights
			theta = theta + (alpha*(epos - eneg))';
        end
    end
end
