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
red2=red';
r1=zeros(size(red2,1),1);
new_data=[red2];
new_data_labels=[r1];
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


