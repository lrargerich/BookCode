function ShowMnistImagesInGrid(imgs,grid)
    imgs=imgs(1:(grid*grid),:);
    imarray=cell(1,grid*grid);
    for i=1:(grid*grid)
        imarray{i}=(reshape(imgs(i,:),28,28));
    end
    imdisp(imarray,'Size',[grid,grid]);
end