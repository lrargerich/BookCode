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
		4.15 4.14 2;
		4.12 4.12 2;
		4.13 4.12 2;
		4.11 4.13 2;
		4.13 4.1 2;
		4.11 4.125 2;
		4.125 4.12 2;
		4.14 4.15 2;
		4.1128 4.126 2];

	
	
real = X(:,3);
X=X(:,1:2);
    
 
idx=repmat(1,size(X,1),1);

% Plot the graph initally	  
fprintf('\nFirst we are going to draw the datapoints...\n\n');
fprintf('\nPress Enter to continue...\n\n');
pause;
figure;
plotDataPoints(X,idx,2);
fprintf('\nPress Enter to continue...\n\n');

pause;
	  
initial_centroids = [3 3; 4 2];
[centroids, idx] = runkMeans(X, initial_centroids, 10, false);

fprintf('\nNow we are going to show what K-Means did with our data\n\n');
fprintf('\nPress Enter to continue...\n\n');
pause;
figure;
plotDataPoints(X,idx,2);
fprintf('\nPress Enter to continue...\n\n');
pause;


sigma=1;
% Compute W matrix using formula: wij = exp( (-1/(2 sigma ^2)) d(xi,xj)^2 )
W = ComputeW(X,sigma);

fprintf('\nComputing Affinity Matrix W\n\n');
fprintf('\nNow we will show a heatmap of the affinity matrix to see if we find patterns\n\n');
fprintf('\nPress Enter to continue...\n\n');
pause;
figure;
imagesc(W);
fprintf('\nPress Enter to continue...\n\n');
pause;

% Compute D diagonal matrix as sum of each rowwww
D=diag(sum(W,2));
% Octave I love you

fprintf('\nComputing Laplacian Matrix L\n\n');
L = (D^(-1/2)) * ((D-W) * (D^(-1/2)));
%L=(D^-1)-W;
%L=D-W;


fprintf('\nComputing Eigenvectors L\n\n');
% Compute V = k principal eigenvectors by row (each row norm1)
[V,d]=eigs(L,2,'sm');

% scatter(1:length(sum(as)),sum(as),15)

fprintf('\nNormalizing Eigenvectors L\n\n');
V=normalizeVector(V);

fprintf('\nWe plot the resulting V matrix to see if we have separated our clusters correctly\n\n');
fprintf('\nPress Enter to continue...\n\n');
pause;
figure;
plotDataPoints(V,real,2)
fprintf('\nPress Enter to continue...\n\n');
pause;



fprintf('\nRunning K-Means in our resulting matrix V\n\n');
% Run K Means on normalized V
initial_centroids=[-0.5 0;0.5 0.5];
[centroids,idx]= runkMeans(V,initial_centroids,10,false);

fprintf('\nWe now plot the result of our clustering algorithm\n\n');
fprintf('\nPress Enter to continue...\n\n');
pause;
figure;
plotDataPoints(X,idx,2)

% scatter(1:length(sum(as)),sum(as),15)
% imagesc(m)