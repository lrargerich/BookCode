function ShowWhichPatches(patches,s,z)
	%% Create table loop accumulate etc 
	k = max(s);
	tabla = zeros(k,1);
	for i= 1:size(s,1)
		if(s(i)~=0)
			tabla(s(i))=tabla(s(i))+1;
		end
	end
	[ss1,ss2]=sort(tabla);
	ss2 = fliplr(ss2');
	ss2 = ss2';

	indexes = ss2(1:(z*z));

	sp = sqrt(size(patches,2));
	for i= 1:(z*z)
		subplot(z,z,i),imshow( RemapImage(reshape(patches(indexes(i),:),sp,sp)));
	end
end	