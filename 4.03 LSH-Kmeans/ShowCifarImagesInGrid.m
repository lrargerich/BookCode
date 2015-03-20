%% This receives a matrix of Color Cifar Images and
%% displays the first grid x grid images in a grid x grid grid :)
function ShowCifarImagesInGrid(imgs,grid)
    imgs=imgs(1:(grid*grid),:);
    imarray=cell(1,grid*grid);
    for i=1:(grid*grid)
        imarray{i}=rot90(reshape(imgs(i,:),32,32,3),3);
    end
    imdisp(imarray,'Size',[grid,grid]);
end