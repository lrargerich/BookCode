function r=visualize(X)
[D,N]= size(X);
s=sqrt(D);
if s==floor(s)
    num=ceil(sqrt(N));
    a=zeros(num*s+num+1,num*s+num+1)-1;
    x=0;
    y=0;
    for i=1:N
        a(x*s+1+x:x*s+s+x,y*s+1+y:y*s+s+y)=reshape(X(:,i),s,s)';
        x=x+1;
        if(x>=num)
            x=0;
            y=y+1;
        end
    end
    d=true;
end
%return the image, or plot the image
imshow(a,[-1,1]);
end
