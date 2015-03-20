%% This creates a LSH structure 
%% X is a matrix of m points in n dimensions (SCALED to 0..1 range!!!)
%% buckets is the number of buckets for each function
%% the total number of hash tables is r*b where:
%% r is the number of AND constructions to use (default=1)
%% b is the number of OR constructions to use (default=1)
function LSH = CreateLSH(X,buckets,r,b,w)
if ~exist('r','var'),r=1;end
if ~exist('b','var'),b=1;end
[m,n]=size(X);
X=Scale(X); %just in case
% Create r*b random projection vectors of n dimensions (normalized to 0..1)
pro = rand(r*b,n);
if ~exist('w','var')
    % Determine bucket width
    w = n/buckets;
end
LSH.table=cell(r*b,1);
LSH.r=r;
LSH.b=b;
LSH.w=w;
LSH.buckets=buckets;
for j=1:(r*b)
    LSH.table{j}=cell(buckets,1);
end

for i=1:size(X,1)
   x=X(i,:);
   for table=1:(r*b)
      % Determine bucket number in this table
      buck_num = 1+floor(dot(x,pro(table,:))/w);
      % Add point to the bucket
      if isempty(LSH.table{table}{buck_num})
         LSH.table{table}{buck_num}=[i];
      else
         LSH.table{table}{buck_num}=[LSH.table{table}{buck_num};i];
      end
   end
end

end