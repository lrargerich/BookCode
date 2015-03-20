function ShowPatches(patches,z)
	aux =(patches(1:z*z,:));
	sp = sqrt(size(patches,2));
	for i= 1:(z*z)
		subplot(z,z,i),imshow( RemapImage(reshape(aux(i,:),sp,sp)'));
	end
end	