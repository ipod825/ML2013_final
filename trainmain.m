global categNum normSideLength isTraining normimgFName n eigenValThred FE CLS ...
    cachefeatureFName featureextracterFName classifierFName...
    featureextracterchanged
isTraining=true;
GLOBALVAR;
if(exist('Y','var') && size(Y,1)~=n)
    featureextracterchanged=true;
    clear Y X F;
end

if(~exist('X','var'))
    [Y, X]=readmatrix(normimgFName,n,normSideLength,normSideLength);
    X=full(X);
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
    load(featureextracterFName);
    fe.copy(featureextracter);
end

if(featureextracterchanged)
    if exist(cachefeatureFName,'file')
        warning('Using cached feature file: %s. Remove it if you have modified the featureextracter.',cachefeatureFName);
        featurecached=true;
        data=dlmread(cachefeatureFName);
        Y=data(:,1);
        F=data(:,2:end);
    else
        F=fe.extract(X);
        if(isTraining)
            featureextracter=fe.saveobj;
            save(featureextracterFName,'featureextracter');
        end
        if ~exist(cachefeatureFName,'file')
            dlmwrite(cachefeatureFName,[Y F]);
        end
    end
    featureextracterchanged=false;
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
    case 6
        cls=DiscrimentClassifier(size(F,2),categNum);
end


cls.train(Y,F);
classifier=cls.saveobj;
save(classifierFName,'classifier');

