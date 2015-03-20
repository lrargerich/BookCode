function maximg = FindMaxImages(theta_ih)
  [h,n]=size(theta_ih);
  theta_ih=theta_ih(:,1:(n-1));
  maximg=[];
  aux=zeros(1,n-1);
  for i=1:h
      sums = sum(theta_ih(i,:).^2);
      for j=1:n-1
        aux(j) = theta_ih(i,j)/(sqrt(sums));
      end
      maximg=[maximg;aux];
  end
end