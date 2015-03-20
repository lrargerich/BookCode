%% Finds the closest node index to x in a grid
%% Grid a matrix of mxn
%% x is a 1xn point
%% we just return the m for the closest point to x
function BMU = FindClosestNode(x,grid)
  min_dist = 9999999;
  BMU=0;
  for i=1:size(grid,1)
     distance=norm(x-grid(i,:));
     %distance=sum((x-grid(i,:)).^2);
     if distance<min_dist
         min_dist=distance;
         BMU=i;
     end
  end
end