subplot(1,2,1)
scatter3(maniX(:,1),maniX(:,2),maniX(:,3),4,ColorVector);
subplot(1,2,2)
scatter(maniY(:,1),maniY(:,2),4,ColorVector);
colormap(jet);