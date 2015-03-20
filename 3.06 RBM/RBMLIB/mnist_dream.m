[model, errors] = rbmBB(mnist2, 400,model,'eta',0.0001,'momentum',0.5);
visualize(model.W);
the_dream=zeros(64,784);

for j=1:64
random_dream = double(rand(1,784));
a_rep = random_dream*model.W+model.b;
for i=1:200
    a_dream= a_rep*model.W'+model.c;    
    a_rep = a_dream*model.W+model.b;
end
%imshow(reshape(RemapImage(a_dream),28,28));
the_dream(j,:)=RemapImage(a_dream);
end
visualize(the_dream');

