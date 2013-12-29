global categNum normSideLength isTraining featureFname n 
isTraining=false;
GLOBALVAR;

if(~exist('cache','var'))
    cache=zeros(1,2);
end

if(~cache(1,1))
    [Y, X]=readmatrix(featureFname,n,normSideLength,normSideLength);
    X=full(X);
    cache(1,1)=true;
end

    FE=2;
    

if(~cache(1,2))
    clear fe; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.
    switch(FE)
        case 1
            fe=DEFeatureExtracter(normSideLength,categNum);
        case 2
            try %test
                eigenVec=dlmread('PCAEigenVecs.mat');
                fe=EigenFeatureExtracter(floor(normSideLength*normSideLength/20),eigenVec);
            catch e %train
                fe=EigenFeatureExtracter(floor(normSideLength*normSideLength/20),[]);
                if(FE==2)
                    dlmwrite('PCAEigenVecs.mat',fe.eigenVec);
                end
            end
    end
    F=fe.extract(X);
    cache(1,2)=true;
end

clear cls; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.

CLS=2;
switch(CLS)
    case 1
       cls=AMDClassifier(size(F,2),categNum);
    case 2
       cls=SVMClassifier(size(F,2),categNum);
end



load 'classifier.mat';
cls.copy(classifier);
pred=cls.classify(F);

dlmwrite('pred.txt',pred);