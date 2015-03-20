function ShowColorImagesInGrid(imgs,grid)
    imgs=imgs(1:(grid*grid),:);
    imarray=cell(1,grid*grid);
    sx=sqrt(size(imgs,2)/3);
    for i=1:(grid*grid)
        imarray{i}=((reshape(imgs(i,:),sx,sx,3)));
    end
    imdisp(imarray,'Size',[grid,grid]);
end