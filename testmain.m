global isTraining classifierFName
isTraining=false;

auxmain; %check auxmain.m

load(classifierFName);
cls.copy(classifier);
pred=cls.classify(F);
dlmwrite('pred.txt',pred);
