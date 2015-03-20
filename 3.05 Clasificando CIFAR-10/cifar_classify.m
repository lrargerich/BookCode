model_n = svmtrain(labels2,imgfts,'-s 0 -t 0 -c 50 -h 0 -m 1024');
[pl,acc,pro] = svmpredict(test_labels2,testfts,model_n);
