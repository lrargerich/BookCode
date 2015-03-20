function ShowFacesImagesInGrid(imgs,grid)
    imgs=imgs(1:(grid*grid),:);
    imarray=cell(1,grid*grid);
    for i=1:(grid*grid)
        imarray{i}=(RemapImage(reshape(imgs(i,:),64,64)));
        %imarray{i}=((reshape(imgs(i,:),64,64)));
    end
    imdisp(imarray,'Size',[grid,grid]);
end