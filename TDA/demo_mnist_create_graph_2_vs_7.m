% Try different eps values and graph Vietoris-Rips Classification
load('datasets/mnist.mat');

% k=1:100 eps=3:100
all_params=linspace(3,10,200);

for digit=0:9
    mnist_do=mnist(labels==digit,:);
    mnist_do=mnist(randperm(200),:);
    J=[];
    counter=1;
    fprintf('*** Processing digit:%d\n',digit);
    for ve=1:size(all_params,2)   
        param=all_params(ve);   
        %fprintf('Processing eps %d/%d\n',counter,size(all_params,2));
        counter=counter+1;
        %fprintf('Building Graph for param=%.2f\n',param);
        graph=VietorisGraphBuilder(mnist_do,param);
        %graph=FastGraphBuilder(mnist,param);
        comp = graphconncomp(graph);
        fprintf('Graph has %d edges and %d components\n',nnz(graph),comp);
        J=[J;comp];
        graphname=sprintf('graphs/mnist_eps_%.2f',param);
        %SaveGraph(graph,labels,graphname);
    end
    plot(all_params,J)
    hold on
end
x=90
legend('0','1','2','3','4','5','6','7','8','9')
xlabel('eps');
ylabel('# of components'); 
title('Mnist Digits # of Components');