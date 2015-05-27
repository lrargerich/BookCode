%[points,labels,w]=CreateTwoClasses(90,2);
[theta,errors]=PerceptronNorm(train_data,sent_train',0.01,100);
