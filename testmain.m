global categNum normSideLength isTraining featureFname n 
isTraining=false;
GLOBALVAR;
[Y, X]=readmatrix(featureFname,n,normSideLength,normSideLength);
X=full(X);


clear fe; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.
fe=DEFeatureExtracter(normSideLength,categNum);

F=zeros(n,fe.d);
h = waitbar(0,'Feature Extraction...');
for i=1:n
    img=reshape(X(i,:),normSideLength,normSideLength);
    F(i,:)=fe.extract(Y(i),img);
    waitbar(i / n);
end
close(h);
% dlmwrite('testFeature.mat',F)
% F=dlmread('testFeature.mat');

load 'cls.mat';
clsTest=AMDClassifier(size(F,2),categNum);
clsTest.copy(cls);
pred=zeros(n,1);
h = waitbar(0,'Testing...');
for i=1:size(pred,1)
    pred(i)=clsTest.classify(F(i));
    waitbar(i/n);
end
close(h);
dlmwrite('pred.txt',pred);