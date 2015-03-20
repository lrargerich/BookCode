 %W = rand(785,401);
 %for j=1:100:1000
 [W,J]=LearnBinaryRBMb(mnist2,400,5,0.10,100,0.50,100,W); 
 %end
 vis = W(2:end,1:400);
 visualize(vis);
 
