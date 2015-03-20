function [best_nu,best_model,best_pre]=TuneOneClassSVM(train,y)
nus=linspace(1e-6,1e-2,200);
gammas=linspace(1/(4*size(train,1)),4/(size(train,1)),20);
best_f1=-99;
best_nu=0;
best_gamma=0;
best_pre=[];
normal=train(y==0,:);
foo=zeros(size(normal,1),1);
for nu=nus 
    s = sprintf('-s 2 -t 2 -n %f',nu);
    model=svmtrain(foo,normal,s);
    pre=svmpredict(y,train,model);
    predictions=(pre+1)/2;
    tp = sum((predictions==0) & (y==1));
    fp = sum((predictions==0) & (y==0));
    fn = sum((predictions==1) & (y==1));	
    precision = tp / (tp+fp);
    recall = tp / (tp+fn);
    F1 = (2*precision*recall)/(precision+recall)    
    
    fprintf('Nu: %f precision:%f recall:%f\n',nu,precision,recall);
    if F1>best_f1
          best_f1=F1;
          best_nu=nu;
          best_model=model;
          best_pre=predictions;
    end   
end
fprintf('best f1: %f best nu: %f\n',best_f1,best_nu);
end
