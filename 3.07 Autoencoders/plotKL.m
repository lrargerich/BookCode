p=0.2
pjs=linspace(0.01,0.99,100);
r=[]
for pj=pjs
   aux=(p*log(p/pj))+((1-p)*log((1-p)/(1-pj)));
   r=[r;aux];
   
end

plot(pjs',r)
