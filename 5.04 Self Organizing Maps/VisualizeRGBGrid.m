%% This assumes we have a square grid 
%% representeed in a grid_size*grid_size x 3 matrix
%% and we visualize it as a single image
function VisualizeRGBGrid(grid,grid_size)
  img=reshape(grid,grid_size,grid_size,3);
  % Now we have a RGB image of grid_size by grid_size
  % we are going to re-scale it to 400x400
  scale_factor = 400/grid_size;
  img=imresize(img,scale_factor);
  imshow(img);
end