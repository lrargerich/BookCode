% Perform "walks" random walks of lentgh "l"
% starting from node "node" and return a vector
% with num_classes probabilities
% This can include unlabeled data please use label=0 for
% unlabeled data and label=1,2,3,etc for labeled data
function probs=RandomWalkerClassifier(graph,labels,num_classes,node,restart,walks,valid_labels,sigma)
    probs=zeros(num_classes,1);
    total=0;
    for i=1:walks
        s=sprintf('node:%d *%d*',node,valid_labels(node));
        current_node = node;
        while rand(1,1)>=restart
            % Pick a random node from current_node weighted by the distances
            v=full(graph(current_node,:));
            if sum(v)>0
                %vsim=exp(-v/(sigma^2));
                %vsim(v==0)=0;
                %vsim=vsim/sum(vsim);
                % all are equiprob all are good!
                v=v/sum(v);
                current_node=randsample(size(v,2),1,true,v);                
                % The node has label=0 if it hasn't been labeled
                if labels(current_node)>0                   
                    [m1,m2]=max(probs);
                    s=sprintf('%s-%d',s,m2);
                    probs(labels(current_node))=probs(labels(current_node))+1;
                    total=total+1;
                end
            end
        end
        s=sprintf('%s\n',s);
        %fprintf(s);
    end
    probs=probs/total;
end