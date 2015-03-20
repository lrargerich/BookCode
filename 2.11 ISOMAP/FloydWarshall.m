%% Vanilla version of the Floyd-Warshall algorithm
%% graph is an mxm sparse matrix with the distance between 
%% node i and node j if they are connected
function graph = FloydWarshall(graph)
    m = size(graph,1);
    %% This can blow up in a catastrophic way if there's not enough memory
    %% to hold the D matrix, it's a complete matrix, no escape!  
    %% Please prepare to wait Matlab is not very good with loops and
    %% we are going to nest three of them.
    %% Please forgive me...
    fprintf('The one and only Floyd Warshall algorithm that talks!\n');
    for k=1:m
        fprintf('Processing round %d of %d\n',k,m);
        for i=1:m
            for j=1:m
                if i~=j
                if graph(i,k)~=0 && graph(k,j)~=0 
                    if (graph(i,k)+graph(k,j)<graph(i,j)) || (graph(i,j)==0)
                        graph(i,j)=graph(i,k)+graph(k,j);
                    end
                end
                end
            end
        end
    end
end