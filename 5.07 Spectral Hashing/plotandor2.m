x=linspace(0,1,100);

r=4;
b=29;

p1 = 0.3
c
y1=zeros(1,100);
for i=1:length(x)
   if x(i)<=p1
       p=0.5;
   else
       p=0.3;
   end
   aux_y1= 1-((1-((p)^r))^b);
   y1(i)=aux_y1;
end

plot(x,y1);
s=sprintf('legend b=%d r=%d',b,r);
legend(s);
xlabel('distance');
ylabel('p');
title('LSH AND-OR Construction');



