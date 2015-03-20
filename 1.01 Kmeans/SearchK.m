function j=SearchK(X,fromK,toK,iter)
    j=[];
    for i=fromK:toK
        [centroids,idx,best_cost] = MultiKmeans(X,i,iter);
        j=[j;best_cost];
    end
    figure
    plot(fromK:toK,j,'r');
    title('Finding K');
    xlabel('K');
    ylabel('Cost');
end
        

