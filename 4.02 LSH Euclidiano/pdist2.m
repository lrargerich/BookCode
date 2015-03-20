function D = pdist2( X, Y, metric )

if( nargin<3 || isempty(metric) ); metric=0; end;

switch metric
  case {0,'sqeuclidean'}
    D = distEucSq( X, Y );
  case 'euclidean'
    D = sqrt(distEucSq( X, Y ));
  case 'L1'    
    D = distL1( X, Y );
  case 'cosine'
    D = distCosine( X, Y );
  case 'emd'
    D = distEmd( X, Y );
  case 'chisq'
    D = distChiSq( X, Y );
  otherwise
    error(['pdist2 - unknown metric: ' metric]);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D = distL1( X, Y )

m = size(X,1);  n = size(Y,1);
mOnes = ones(1,m); D = zeros(m,n);
for i=1:n
  yi = Y(i,:);  yi = yi( mOnes, : );
  D(:,i) = sum( abs( X-yi),2 );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D = distCosine( X, Y )

if( ~isa(X,'double') || ~isa(Y,'double'))
  error( 'Inputs must be of type double'); end;

p=size(X,2);
XX = sqrt(sum(X.*X,2)); X = X ./ XX(:,ones(1,p));
YY = sqrt(sum(Y.*Y,2)); Y = Y ./ YY(:,ones(1,p));
D = 1 - X*Y';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D = distEmd( X, Y )

Xcdf = cumsum(X,2);
Ycdf = cumsum(Y,2);

m = size(X,1);  n = size(Y,1);
mOnes = ones(1,m); D = zeros(m,n);
for i=1:n
  ycdf = Ycdf(i,:);
  ycdfRep = ycdf( mOnes, : );
  D(:,i) = sum(abs(Xcdf - ycdfRep),2);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D = distChiSq( X, Y )

%%% supposedly it's possible to implement this without a loop!
m = size(X,1);  n = size(Y,1);
mOnes = ones(1,m); D = zeros(m,n);
for i=1:n
  yi = Y(i,:);  yiRep = yi( mOnes, : );
  s = yiRep + X;    d = yiRep - X;
  D(:,i) = sum( d.^2 ./ (s+eps), 2 );
end
D = D/2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D = distEucSq( X, Y )

%if( ~isa(X,'double') || ~isa(Y,'double'))
 % error( 'Inputs must be of type double'); end;
m = size(X,1); n = size(Y,1);
%Yt = Y';
XX = sum(X.*X,2);
YY = sum(Y'.*Y',1);
D = XX(:,ones(1,n)) + YY(ones(1,m),:) - 2*X*Y';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function D = distEucSq( X, Y )
%%%% code from Charles Elkan with variables renamed
% m = size(X,1); n = size(Y,1);
% D = sum(X.^2, 2) * ones(1,n) + ones(m,1) * sum(Y.^2, 2)' - 2.*X*Y';


%%% LOOP METHOD - SLOW
% [m p] = size(X);
% [n p] = size(Y);
%
% D = zeros(m,n);
% onesM = ones(m,1);
% for i=1:n
%   y = Y(i,:);
%   d = X - y(onesM,:);
%   D(:,i) = sum( d.*d, 2 );
% end


%%% PARALLEL METHOD THAT IS SUPER SLOW (slower then loop)!
% % From "MATLAB array manipulation tips and tricks" by Peter J. Acklam
% Xb = permute(X, [1 3 2]);
% Yb = permute(Y, [3 1 2]);
% D = sum( (Xb(:,ones(1,n),:) - Yb(ones(1,m),:,:)).^2, 3);


%%% USELESS FOR EVEN VERY LARGE ARRAYS X=16000x1000!! and Y=100x1000
% call recursively to save memory
% if( (m+n)*p > 10^5 && (m>1 || n>1))
%   if( m>n )
%     X1 = X(1:floor(end/2),:);
%     X2 = X((floor(end/2)+1):end,:);
%     D1 = distEucSq( X1, Y );
%     D2 = distEucSq( X2, Y );
%     D = cat( 1, D1, D2 );
%   else
%     Y1 = Y(1:floor(end/2),:);
%     Y2 = Y((floor(end/2)+1):end,:);
%     D1 = distEucSq( X, Y1 );
%     D2 = distEucSq( X, Y2 );
%     D = cat( 2, D1, D2 );
%   end
%   return;
% end