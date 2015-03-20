function ShowGSImage(data,i)
	imshow(RemapImage(reshape(data(i,:),32,32)'));
end	