function visible = rbmShowVisible(hidden,theta)
	hidden = [hidden , 1];
	visible = sigmoid(hidden * theta);
	for j=2:size(visible,2)
		roll = rand(1,1);
		if roll < visible(j)
			visible(j)=1;
		else
			visible(j)=0;
		endif
	end
	fin = size(visible,2);
	visible=visible(:,2:fin);
end