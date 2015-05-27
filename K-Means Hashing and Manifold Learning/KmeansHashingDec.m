function [codes,centroids,code_values,dec_codes] = KmeansHashingDec(X,k,max_iter)
  if ~exist('max_iter','var')
    max_iter=100;
  end
  addpath Kmeans/
  
  [m,n]=size(X);
  
  % Do a first split
  %[cen,idx,best,all]=MultiKmeans(X,2,max_iter);
  [cen,idx,dists]=Kmeans(X,2,max_iter);
  centroids=cell(k,1);
  centroids{1}=cen;
  % Convert centroid assignments to binary 0-1 our first codes
  codes=idx-1;
  code_values=bi2de((codes));
  % Decimal Codes
  for i=1:(k-1)
     fprintf('Creating bitcode vector %d/%d\n',i,k-1);
     new_codes=zeros(m,1);
     new_dec_codes=zeros(m,2);
     for j=0:(2^i)-1
        selector = (code_values==j);
        if sum(selector)>0
            %[cen,idx,best,all]=MultiKmeans(X(selector==1,:),2,max_iter);
            [cen,idx,dists]=Kmeans(X(selector==1,:),2,max_iter);
            split_size=sum(idx==1)/length(X(selector==1));
            % Now I add the idx to the codes
            idx=idx-1;
            new_codes(selector==1)=idx;
        else
            cen=zeros(2,n);
        end
        centroids{i+1}=[centroids{i+1};cen];
     end
     codes=[codes,new_codes];
     code_values=bi2de((codes));
  end
  code_values=bi2de((codes));
  % Now the decimal codes
  dec_codes=[];
  %for i=1:size(centroids,1)
     cen=centroids{size(centroids,1)};
     [idx,dists] = FindClosestCentroids(X, cen);
     codes=bsxfun(@minus,mean(dists),dists);
     codes(codes<0)=0;
     dec_codes=[dec_codes,codes];
  %end
end