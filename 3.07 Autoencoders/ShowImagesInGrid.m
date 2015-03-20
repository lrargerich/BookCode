function ShowImagesInGrid(imgs,grid)
    imgs=imgs(1:(grid*grid),:);
    imarray=cell(1,grid*grid);
    sx=sqrt(size(imgs,2));
    for i=1:(grid*grid)
        imarray{i}=(RemapImage(reshape(imgs(i,:),sx,sx)));
    end
    imdisp(imarray,'Size',[grid,grid]);
end