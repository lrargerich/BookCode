faces_32=[];
for i=1:400
    a_face=reshape(imresize(reshape(faces(i,:),64,64),0.5),1,32*32);
    faces_32=[faces_32;a_face];
end