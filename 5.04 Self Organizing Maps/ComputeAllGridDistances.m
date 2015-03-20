function mat=ComputeAllGridDistances(grid_size)
    mat=zeros(grid_size,grid_size);
    for i=1:(grid_size*grid_size)
        for j=i+1:(grid_size*grid_size)
            x_x = 1+floor((i-1)/grid_size);
            x_y = 1+mod((i-1),grid_size);
            y_x = 1+floor((j-1)/grid_size);
            y_y = 1+mod((j-1),grid_size);
            mat(i,j) = norm([x_x,x_y]-[y_x,y_y]);
            mat(j,i) = mat(i,j);
        end
    end
end