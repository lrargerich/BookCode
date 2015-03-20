function ShowImagesInGrid(imgs,grid,noremap)
    imgs=imgs(1:(grid*grid),:);
    imarray=cell(1,grid*grid);
    sx=sqrt(size(imgs,2));
    for i=1:(grid*grid)
        if ~exist('noremap','var')
        imarray{i}=(RemapImage(reshape(imgs(i,:),sx,sx)));
        else
        imarray{i}=((reshape(imgs(i,:),sx,sx)));
        end
    end
    imdisp(imarray,'Size',[grid,grid]);
end