% RETOCAR ESTO
% EN PRIMER LUGAR PONER PROB BETA PARA RANDOMWALKERCLASSIFIER
% EN SEGUNDO LUGAR HACER LOS PLOTS PERSISTENTES VIA SCATTER
% EN TERCER LUGAR PROBAR LOS PLOTS VARIANDO EPSILON O BETA

% Try different eps values and graph Vietoris-Rips Classification
load('Mnist/mini_mnist.mat');
mnist=mini_mnist;
labels=mini_labels;
k=0;
eps=0;
sigma=1;
%all_eps=linspace(3,10,100);
all_ks=1:100;
J=[];
matrix_results=zeros(floor(size(mnist,1)*0.2),size(all_ks,2),10);
class_acc=zeros(floor(size(mnist,1)*0.2),size(all_ks,2));
for ve=1:size(all_ks,2)   
    %eps=all_eps(ve);
    k=all_ks(ve);
    %k=0;
    eps=k;   
    fprintf('Building Vietoris Rips Complex for k=%d eps=%.2f\n',k,eps);
    %graph=VietorisGraphBuilder(mnist,eps);
    graph=FastGraphBuilder(mnist,k);
    xx=full(mean(mean(graph)));
    fprintf('Graph has %d edges mean distance %f\n',nnz(graph),xx);
    %graphname=sprintf('mnist_k_%.2f',eps);
    %SaveGraph(graph,labels,graphname);
    valid_labels=labels+1;
    new_labels=valid_labels;
    base_probs=zeros(10,1);
    for i=1:size(mnist,1)
        base_probs=base_probs+RandomWalkerClassifier(graph,new_labels,10,i,0.2,100,valid_labels,sigma);
    end
    base_probs=base_probs/size(mnist,1);
    plot(base_probs);
    hold on;
    
    rp = randperm(size(mnist,1));
    rp = rp(1:(floor(size(mnist,1)*0.2)));
    
    new_labels=valid_labels;
    new_labels(rp)=0;
    % Now do the dance
    walks=100;
    restart=0.35;
    right=0;
    wrong=0;
    new_labels=valid_labels;
    new_labels(rp)=0;
    true_labels=zeros(size(rp,2),1);
    for i=1:size(rp,2)
        node = rp(i);
        probs=RandomWalkerClassifier(graph,new_labels,10,node,0.2,walks,valid_labels,sigma);
        weights = 1-(base_probs/sum(base_probs));
        probs = probs.*weights;
        probs(isnan(probs))=0;
        [m1,m2]=max(probs);      
        new_labels(node)=m2;
        true_labels(i)=valid_labels(node);
        matrix_results(i,ve,:)=probs;
        if m1~=0
            class_acc(i,ve)=m2;
        else
            class_acc(i,ve)=nan;
        end
        if m2==valid_labels(node)
            right = right+1;
        else
            wrong = wrong+1;
        end
    end
    acc=100*right/(right+wrong);
    J=[J;acc];
    fprintf('We got %d right of %d accuracy=%f\n',right,right+wrong,acc);
end
figure
plot(all_ks,J);
xlabel('K');
ylabel('Accuracy');
title('Mnist Accuracy');
% HERE BE DRAGONS
% Matrix results is 200x150x10 (200 items, 150 runs, 10 classes)
% Un roll one particular observation for every class along runs
pindex=1
for iii=1:10
figure
my_observation = matrix_results(iii,:,:);
my_observation = reshape(my_observation,size(all_ks,2),10);
% Now we have a 150x10 matrix
%for i=1:10
%    plot(all_eps,my_observation(:,i));
%    hold on;
%end
%xlabel('K');
%ylabel('Probability');
%s=sprintf('Probability for each class observation:%d',iii);
%title(s)
%legend('class 0','class 1','class 2','class 3','class 4','class 5','class 6','class 7','class 8','class 9','class 10');
% Create Persistance graph
my_observation = class_acc(iii,:);
%plot(all_eps,class_acc(iii,:));
scatter(all_ks,my_observation,15,'filled')
tl = true_labels(iii);
s=sprintf('Assigned class for observation:%d class:%d',iii,tl);
xlabel('eps');
ylabel('Class');
title(s)
end