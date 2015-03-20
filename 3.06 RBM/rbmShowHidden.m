function hidden = rbmShowHidden(sample,theta)
	dim = size(theta,1);
	sample = [1, sample];
	hidden = sigmoid(sample*theta');
	hidden = hidden(:,1:dim-1);
	for j = 1:dim-1
		roll = rand(1,1);
		if roll<hidden(j)
			hidden(j)=1;
		else
			hidden(j)=0;
	end
end	