global isTraining classifierFName
isTraining=false;

auxmain; %check auxmain.m

load(classifierFName);
cls.copy(classifier);
pred=cls.classify(F);
dlmwrite('pred.txt',pred);
load './data/ans1.dat'
pred=pred-ans1;
accuracy=size(find(pred==0),1)/size(F,1)