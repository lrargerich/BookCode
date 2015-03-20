for i=1:9
    subplot(3,3,i)
    imshow(reshape(gimgs(floor(1+rand()*50000),:)/255,32,32));
end