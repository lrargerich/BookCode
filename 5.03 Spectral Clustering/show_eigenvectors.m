for i=1:2
    subplot(1,2,i),plot(v(:,i))
    s=sprintf('v%d',i);
    title(s)
end