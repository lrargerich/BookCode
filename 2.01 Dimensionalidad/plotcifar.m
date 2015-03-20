for i=1:9
    subplot(3,3,i)
    axis([0 256 0 256])
    digitx1=floor(rand()*32+1);    
    digity1=floor(rand()*32+1);  
    digitx=gimgs(:,digitx1*digity1);
    digitx2=floor(rand()*32+1);    
    digity2=floor(rand()*32+1);  
    digity=gimgs(:,digitx2*digity2);
    
    scatplot(digitx,digity);
    xlabel(sprintf('pixel %d-%d',digitx1,digity1));
    ylabel(sprintf('pixel %d-%d',digitx2,digity2));
end