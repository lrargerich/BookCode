function PlotSoftKmeans(X,centroids,clusters)
colors = [ 255,0,0;  %red
           0, 255,0; %green
           0, 0, 255; %blue
           255,255,0; %yellow
           255,192,103; %pink
           255,218,185; %peach
           255,128,0; %orange
           0,255,255; %cyan (Aqua for girls)
           99,184,255; %steelblue
           209,95,238; %purplish
           112,128,144; %slate gray
           227,207,87; %banana
           245,222,179; %wheat
           255,114,86; %coral
           128,0,0; %maroon
           198,113,113; %salmon
           0,100,0; %dark green
         ];

colors=colors/255;

% We'll use as many colors as centroids     
colors=colors(1:size(centroids,1),:);     

% Colors are centroid colors
scatter(centroids(:,1),centroids(:,2),20,colors,'filled');
hold on
% Compute the color of each point
point_colors= (clusters*colors);
scatter(X(:,1),X(:,2),62,point_colors,'filled');
hold on
plot(centroids(:,1),centroids(:,2),'bx','Markersize',10);

   
     
end