x=linspace(0,1,100);

r=2;
b=r;

p1 = 0.3
p2 = 0.7

y=zeros(1,100);
for i=1:length(x)
   point = x(i);
   if x<=0.3
       y1= 1-((1-(0.5^r))^b);
   elseif x>=0.7
       y1= 1-((1-((1/3)^r))^b);
   end
   
       
end



%y= 1-((1-(x.^r)).^b);


y2= 1-((1-(x.^3)).^2);
y3= 1-((1-(x.^4)).^2);
y4= 1-((1-(x.^5)).^2);
y5= 1-((1-(x.^6)).^2);
y6= 1-((1-(x.^7)).^2);



plot(x,y1,x,y2,x,y3,x,y4,x,y5,x,y6)
legend('r=2','r=3','r=4','r=5','r=6','r=7');
xlabel('p');
ylabel('new p');
title('# of AND Constructions');
