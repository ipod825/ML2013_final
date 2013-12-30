global categNum normSideLength isTraining featureFname n eigenValThred
isTraining=true;
GLOBALVAR;

if(~exist('cache','var'))
    cache=zeros(1,2);
end

if(~cache(1,1))%cache X
    [Y, X]=readmatrix(featureFname,n,normSideLength,normSideLength);
    X=full(X);
    cache(1,1)=true;
end

FE=2;
clear fe; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.
switch(FE)
    case 1
        fe=DEFeatureExtracter(normSideLength,categNum);
    case 2
        fe=EigenFeatureExtracter(eigenValThred,[]);
end
if(~isTraining)
    load 'featureextracter.mat';
    fe.copy(featureextracter);
end

if(~cache(1,2))%cache F
    F=fe.extract(X);
    if(isTraining)
        featureextracter=fe.saveobj;
        save('featureextracter.mat','featureextracter');
    end
    cache(1,2)=true;
end


for gamma=[0.01, 0.1 1 10]
    for C=[0.01, 0.1 1 10]
        clear cls;
        cls=SVMClassifier(size(F,2),categNum);
        Eval=cls.crossvalidation(Y,F,5);
        [gamma C Eval]
    end
end