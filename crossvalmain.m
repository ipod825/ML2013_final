global isTraining fold
isTraining=true;

auxmain; %check auxmain.m
Eval=cls.crossvalidation(Y,F,fold);
