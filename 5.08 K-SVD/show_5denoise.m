figure;
a_face6=reshape(a_face,64,64);
subplot(1,5,1)
av_face1=0.2*(a_face6)+0.8*(new_face2);
imshow(RemapImage(av_face1));

subplot(1,5,2)
av_face2=0.4*(a_face6)+0.6*(new_face2);
imshow(RemapImage(av_face2));

subplot(1,5,3)
av_face3=0.5*(a_face6)+0.5*(new_face2);
imshow(RemapImage(av_face3));

subplot(1,5,4)
av_face4=0.6*(a_face6)+0.4*(new_face2);
imshow(RemapImage(av_face4));

subplot(1,5,5)
av_face5=0.8*(a_face6)+0.2*(new_face2);
imshow(RemapImage(av_face5));