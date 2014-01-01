global categNum normSideLength isTraining n featurecached  normimgFName cachefeatureFName featureextracterFName 
global FE CLS
global eigenValThred
GLOBALVAR;  % Some global variables are set depends on the value of isTraining(set in trainmain.m or testmain.m)

if(~exist('Y','var'))   % check if normalized image has been loaded
    [Y, X]=readmatrix(normimgFName,n,normSideLength,normSideLength);
    X=full(X);
elseif(size(Y,1)~=n)    % check if the cached Y X F are not right(i.e cached training data when testing)
    [Y, X]=readmatrix(normimgFName,n,normSideLength,normSideLength);
    X=full(X);
    featurecached=false; 
end

clear fe; 
switch(FE)
    case 1 
        fe=DEFeatureExtracter(normSideLength,categNum);
    case 2 
        fe=EigenFeatureExtracter(eigenValThred,[]);
    case 3 
        fe=WeightFeatureExtracter(normSideLength, categNum);
end
if(~isTraining) % for some feature extracter, we save some information at training and load it when testing
    load(featureextracterFName);
    fe.copy(featureextracter);
end

cachingFeatureOffline=true;
if(~exist('F','var') || ~featurecached) 
    if exist(cachefeatureFName,'file')
        warning('Using cached feature file: %s. Remove it if you have modified the featureextracter.',cachefeatureFName);
        data=dlmread(cachefeatureFName);
        Y=data(:,1);
        F=data(:,2:end);
    else
        F=fe.extract(X);
        if(isTraining)
            featureextracter=fe.saveobj;
            save(featureextracterFName,'featureextracter');
        end
        if (cachingFeatureOffline)
            dlmwrite(cachefeatureFName,[Y F]);
        end
    end
    featurecached=true;
end

clear cls;
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