function [best_eps]=FindThreshold(X,y)
  eps=1;
  best_eps=1;
  best_f1=-99;  

  p = PointProbability(X);
 
  all_eps=linspace(1e-15,1,1000);
  f1_curve=[];
  
  for eps=all_eps
      predictions = p<eps;  
      
      tp = sum((predictions==1) & (y==1));
	  fp = sum((predictions==1) & (y==0));
	  fn = sum((predictions==0) & (y==1));
	
      precision = tp / (tp+fp);
	  recall = tp / (tp+fn);
      F1 = (2*precision*recall)/(precision+recall);
      f1_curve=[f1_curve;F1];
      if F1>best_f1
          best_f1=F1;
          best_eps=eps;
      end
          
      fprintf('Threshold: %f precision:%f recall:%f\n',eps,precision,recall);
  end
  fprintf('Best eps=%f\n',best_eps);
  figure;
  plot(all_eps,f1_curve);
  xlabel('threshold');
  ylabel('F1 SCORE');
  title('Finding Threshold');
end