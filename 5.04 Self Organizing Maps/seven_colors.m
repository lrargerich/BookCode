colors = [ 255,0,0;  %red
           0, 255,0; %green
           0, 0, 255; %blue
           255,255,0; %yellow
           255,192,103; %pink
           255,218,185; %peach
           255,128,0; %orange
           ];
       

data=repmat(colors,20,1);
data=data/255;
grid7=SOM(data,20,12);
VisualizeRGBGrid(grid7,20);