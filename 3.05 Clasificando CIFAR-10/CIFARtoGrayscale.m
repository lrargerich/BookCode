function gimgs = CIFARtoGrayscale(imgs)
	%0.2989 * R + 0.5870 * G + 0.1140 * B 
	%imgs = double(imgs)/255;
	imgs = double(imgs);
	dims = size(imgs,2);
	gimgs = zeros(size(imgs,1),dims/3);
	dims = dims/3;
	for i=1:size(imgs,1)
		gimgs(i,:) = (0.2989 * imgs(i,1:dims)) + (0.5870*imgs(i,(dims+1):(dims*2))) + (0.1140*imgs(i,(dims*2+1):end));
	end
end