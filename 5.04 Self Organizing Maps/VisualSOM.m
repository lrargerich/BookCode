function grid=VisualSOM(X,grid_size,iterations,alpha,lambda,grid)
m = size(X,1);
n = size(X,2);

if ~exist('lambda','var')
    lambda=iterations;
end
if ~exist('alpha0','var')
    alpha0=0.1;
end
if ~exist('grid','var')
    grid=rand(grid_size*grid_size,n);
end

all_distances=ComputeAllGridDistances(grid_size);

sigma0 = floor(grid_size/2);
figure(1);
ShowFacesImagesInGrid(grid,grid_size)
for ii=1:iterations
   fprintf('Iteration: %d of %d\n',ii,iterations);
   alpha = alpha0*exp(-ii/lambda);
   %Random permutation of the data
   rp=randperm(m);
   for i=1:m
       % So this takes a random point
       x=X(rp(i),:);
       % Search closest match from grid (BMU is a grid point index)
       BMU = FindClosestNode(x,grid);
       % Compute width of neighborhood
       sigma = sigma0 * exp(-ii/lambda); 
       % update all neighbors
       for j=1:(grid_size*grid_size)
           %distance = ComputeGridDistance(j,BMU,grid_size);
           distance = all_distances(j,BMU);
           if distance < (sigma)
              % compute influence
              influence=exp(-distance^2/(2*(sigma^2)));
              % update node
              grid(j,:)= grid(j,:)+influence * alpha * (x-grid(j,:));
           end
       end
       
   end
   ShowFacesImagesInGrid(grid,grid_size)
   pause(0.1);
end
end