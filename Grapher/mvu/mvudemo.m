clear all;

 addpath(genpath(pwd)); %% adding path for SeDuMi solver (CSDP is faster - so go and install that.)  
 tt=(linspace(0,1,100).^0.65).*3*pi+pi;  
 X=[tt.*cos(tt); tt.*sin(tt)];             % generates spiral input data
 figure;
 h1=scatter(X(1,:),X(2,:),140,tt,'filled');   % plots input data
 title('INPUT DATA');
 set(h1,'MarkerEdgeColor',[0.5 0.5 0.5]);   % draw edges around dots
 drawnow;
 axis equal;
 [Y Det]=mvu(distance(X),3,'maxiter',20,'inequ',1,'outdim',2);            % runs mvu (with inequalities)
 figure;
 h2=scatter(Y(1,:),Y(2,:),140,tt,'filled');   % plots output data
 set(h2,'MarkerEdgeColor',[0.5 0.5 0.5]);   % draw edges around dots
 title('OUTPUT DATA');
 axis equal;   
