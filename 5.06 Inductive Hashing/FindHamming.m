%% Returns all the vectors of C that
%% differ at most n bits from x
function results = FindHamming(x,C,n)
results=[];
for i=1:size(C,1)
   diff=length(x)-sum(C(i,:)==x);
   if diff<=n
       results=[results;i];
   end
end
end