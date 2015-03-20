function PlotData(X, y)
figure; hold on;
good = find(y==1);  % y=1 indices
bad = find(y==0); % y =0 indices
plot(X(good,1),X(good,2),'k+','Linewidth',2,'MarkerSize',7);
plot(X(bad,1),X(bad,2),'ko','MarkerFaceColor','y','MarkerSize',7);








% =========================================================================



hold off;

end
