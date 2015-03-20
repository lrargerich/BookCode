load('datareg.mat');
for i=2:5
    subplot(2,2,i-1)
    scatter(data(:,1),data(:,2),38,'filled');
    hold on;
    p=polyfit(data(:,1),data(:,2),i);
    y=polyval(p,x);
    plot(x,y);
    s=sprintf('degree=%d',i);
    title(s);
end
    