[mn_codes,mn_cen,mn_values]=KmeansHashing(mnist,14);
[u1,s1,v1]=svds(mnist,2);
figure
scatter(u1(:,1),u1(:,2),10,labels+1)
figure
[u2,s2,v2]=svds(mn_codes,2);
scatter(u2(:,1),u2(:,2),10,labels+1)