% Create vector X and idx
X = [ 	1.1 2.4 1;
		1 3.2 1;
		1.1 4.1 1;
		1.2 5 1;
		1.5 5.6 1;
		1.8 6.1 1;
		2.2 7 1;
		2.6 7.1 1;
		3 7.2 1;
		3.4 7.2 1;
		4 7.3 1;
		4.5 7.2 1;
		5.2 7.1 1;
		6.2 6.8 1;
		7 5.8 1;
		7.4 5.2 1;
		7.8 3.8 1;
		8 3 1;
		7.8 2.2 1;
		7.2 1.4 1;
		6.2 1.2 1;
		5.5 1 1;
		4.5 0.8 1;
		3.5 1 1;
		2.8 1.2 1;
		2 1.4 1;
		1.8 2.0 1;
		4.5 4.14 2;
		4.12 4.12 2;
		4.13 4.12 2;
		3.87 3.9 2;
		4.13 4.1 2;
		3.9 4.125 2;
		4.125 4.62 2;
		4.14 4.15 2;
		4.1128 4.126 2];

	
	
real = X(:,3);
X=X(:,1:2);
    
 
idx=repmat(1,size(X,1));

% Plot the graph initally	  
fprintf('\nFirst we are going to draw the datapoints...');
fprintf('\nPress Enter to continue...');
pause;
plotDataPoints(X,idx,2);
fprintf('\nPress Enter to continue...');
pause;
	  
initial_centroids = [3 3; 4 2];
[centroids, idx] = runkMeans(X, initial_centroids, 10, false);

fprintf('\nNow we are going to show what K-Means did with our data');
fprintf('\nPress Enter to continue...');
pause;
plotDataPoints(X,idx,2);
fprintf('\nPress Enter to continue...');
pause;


sigma=1;
% Compute W matrix using formula: wij = exp( (-1/(2 sigma ^2)) d(xi,xj)^2 )
W = computeW(X,sigma);

fprintf('\nComputing Affinity Matrix W');
fprintf('\nNow we will show a heatmap of the affinity matrix to see if we find patterns');
fprintf('\nPress Enter to continue...');
pause;
imagesc(W);
fprintf('\nPress Enter to continue...');
pause;

% Compute D diagonal matrix as sum of each rowwww
D=diag(sum(W,2));
% Octave I love you

fprintf('\nComputing Laplacian Matrix L');
L = (D^(-1/2)) * ((D-W) * (D^(-1/2)));
%L=(D^-1)-W;
%L=D-W;


fprintf('\nComputing Eigenvectors L');
% Compute V = k principal eigenvectors by row (each row norm1)
[V,d]=eigs(L,2,'sm');

% scatter(1:length(sum(as)),sum(as),15)

fprintf('\nNormalizing Eigenvectors L');
V=normalizeVector(V);

fprintf('\nWe plot the resulting V matrix to see if we have separated our clusters correctly');
fprintf('\nPress Enter to continue...');
pause;
plotDataPoints(V,real,2)
fprintf('\nPress Enter to continue...');
pause;



fprintf('\nRunning K-Means in our resulting matrix V');
% Run K Means on normalized V
initial_centroids=[-0.5 0;0.5 0.5];
[centroids,idx]= runkMeans(V,initial_centroids,10,false);

fprintf('\nWe now plot the result of our clustering algorithm');
fprintf('\nPress Enter to continue...');
pause;
plotDataPoints(X,idx,2)

% scatter(1:length(sum(as)),sum(as),15)
% imagesc(m)