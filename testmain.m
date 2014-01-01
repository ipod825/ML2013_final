global categNum normSideLength isTraining featureFname n eigenValThred cachefeatureFName FE CLS
isTraining=false;
GLOBALVAR;

featurecached=false;
if exist(cachefeatureFName,'file')
    featurecached=true;
    data=dlmread(cachefeatureFName);
    Y=data(:,1);
    F=data(:,2:end);
    cache=ones(1,2);
end

if(~exist('cache','var'))
    cache=zeros(1,2);
end

if(~cache(1,1))%cache X
    [Y, X]=readmatrix(featureFname,n,normSideLength,normSideLength);
    X=full(X);
    cache(1,1)=true;
end

clear fe; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.
switch(FE)
    case 1
        fe=DEFeatureExtracter(normSideLength,categNum);
    case 2
        fe=EigenFeatureExtracter(eigenValThred,[]);
    case 3
        fe=WeightFeatureExtracter(normSideLength, categNum);
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
    dlmwrite(cachefeatureFName,[Y F]);
    cache(1,2)=true;
end

clear cls; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.
switch(CLS)
    case 1
       cls=AMDClassifier(size(F,2),categNum);
    case 2
       cls=SVMClassifier(size(F,2),categNum);
    case 3
        cls=KNNClassifier(size(F,2),categNum);
    case 4
        cls=NaieveBayesClassifier(size(F,2),categNum);
    case 5
        cls=DecisionTreeClassifier(size(F,2),categNum);
end

load 'classifier.mat';
cls.copy(classifier);
pred=cls.classify(F);

dlmwrite('pred.txt',pred);
