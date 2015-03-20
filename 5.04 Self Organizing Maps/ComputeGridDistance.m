%% Computes the distance between two points in a grid
%% The grid is grid_size x grid_size
%% x and y are indexes in the grid
%% We compute the distance not between the grid content
%% but between the Grid Coordinates!!! this is why this is not just
%% a normal euclidean distance thingy
function distance = ComputeGridDistance(x,y,grid_size)
    x_x = 1+floor((x-1)/grid_size);
    x_y = 1+mod((x-1),grid_size);
    y_x = 1+floor((y-1)/grid_size);
    y_y = 1+mod((y-1),grid_size);
    distance = norm([x_x,x_y]-[y_x,y_y]);
    %distance = sum(([x_x,x_y]-[y_x,y_y]).^2);
end