figure;
axis([-10 10 -10 10])
hold on
grid on;
% Initially, the list of points is empty.
red = [];
blue = [];
green = [];

% Loop, picking up the points for the red class.
disp('---')
disp('Click in the graph for the red points, e.g. in a wide circular form')
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')
but = 1;
n = 0;
while but == 1
    [xi,yi,but] = ginput(1);
    plot(xi,yi,'ro')
    n = n+1;
    red(:,n) = [xi;yi];
end
 
disp('Finished collection red points')
disp('---')
 
% Loop again, picking up the points for the blue class
disp('Now click in the graph for the blue points, e.g. in a smaller circular form')
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')
but = 1;
n = 0;
while but == 1
    [xi,yi,but] = ginput(1);
    plot(xi,yi,'bo')
    n = n+1;
    blue(:,n) = [xi;yi];
end
 
disp('Finished collection blue points')
disp('---')

but = 1;
n = 0;

while but == 1
    [xi,yi,but] = ginput(1);
    plot(xi,yi,'go')
    n = n+1;
    green(:,n) = [xi;yi];
end

blue2=blue';
red2=red';
green2=green';
b1=ones(size(blue2,1),1);
r1=zeros(size(red2,1),1);
g1=zeros(size(green2,1),1)+2;
new_data=[blue2;red2;green2];
new_data_labels=[b1;r1;g1];

data=new_data;
labels=new_data_labels;

clear b1;
clear blue;
clear blue2;
clear but;
clear green;
clear green2;
clear n;
clear new_data;
clear new_data_labels;
clear r1;
clear red;
clear red2;
clear xi;
clear yi;
clear g1;
