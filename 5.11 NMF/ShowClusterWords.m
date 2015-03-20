function ShowClusterWords(w,clus,wdic)
[s1,s2]=sort(w(:,clus),'descend');
some=s2(1:10);
for i=1:length(some)
   w=wdic(some(i));
   fprintf(strcat(w{1},'\n'));
end
end
