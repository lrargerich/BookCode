% Try different eps values and graph Vietoris-Rips Classification
load('datasets/mini_mnist.mat');
mnist=mini_mnist;
labels=mini_labels;

% k=1:100 eps=3:100
all_params=linspace(3,10,100);

J=[];
JR=[];
for ve=1:size(all_params,2)   
    param=all_params(ve);
    fprintf('Building Graph for param=%.2f\n',param);
    graph=VietorisGraphBuilder(mnist,param);
    %graph=FastGraphBuilder(mnist,param);
    graphr=RandomGraph(1000,nnz(graph));
    comp = graphconncomp(graph);
    compr = graphconncomp(graphr);
    fprintf('Graph has %d edges and %d components (random=%d)\n',nnz(graph),comp,compr);
    J=[J;comp];
    JR=[JR;compr];
    graphname=sprintf('graphs/mnist_eps_%.2f',param);
    %SaveGraph(graph,labels,graphname);
end

plot(all_params,J);hold on;plot(all_params,JR)
legend('Mnist','Random')
xlabel('eps')
ylabel('# of components')
title('Mnist Components')