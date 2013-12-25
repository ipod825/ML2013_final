global height width categNum normSideLength isTraining dataFname n 
isTraining=false;
GLOBALVAR;

[Y,X]=readmatrix(dataFname,n,height,width);
Xnorm=cell(n,1);
h = waitbar(0,'Normalization...');
for i=1:n
    Xnorm{i,1}=normalizeImg(X(i,:),normSideLength);
    waitbar(i / n);
end
close(h);

fe=DEFeatureExtracter(normSideLength,categNum);
F=zeros(n,fe.d);
h = waitbar(0,'Feature Extraction...');
for i=1:n
    F(i,:)=fe.extract(Y(i),Xnorm{i});
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
dlmwrite('pred.txt',pred)