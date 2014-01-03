global isTraining classifierFName
isTraining=true;

auxmain; %check auxmain.m

cls.train(Y,F);
classifier=cls.saveobj;
save(classifierFName,'classifier');

