% Movies (Columns)
% 1: Harry Potter
% 2: Lord of the Rings
% 3: The Hobbit
% 4: Star Wars
% 5: Blade Runner
% 6: Metropolis
% 7: Terminator

X=[ 5,4,4,1,1,-100,-100;
    -100,2,2,-100,5,5,3;
    1,-100,1,4,5,3,5;
    -100,5,5,3,1,1,3;
    -100,2,1,2,5,5,-100;
    4,5,5,2,1,-100,1;]

[u,v] = UVDecomp(X,2,100,3)
    