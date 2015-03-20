function img=RemapImage(img)
	img = double(img);
	mini = min(min(img));
	maxi = max(max(img));
	inte = maxi-mini;
	img = img-mini;
	img = img / inte;
end