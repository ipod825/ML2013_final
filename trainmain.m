global categNum normSideLength isTraining normimgFName n eigenValThred FE CLS...
    cachefeatureFName featureextracterFName classifierFName...
    featureextracterchanged
isTraining=true;
GLOBALVAR;

featurecached=false;
if exist(cachefeatureFName,'file')
    warning('Using cached feature file: %s. Remove it if you have modified the featureextracter.',cachefeatureFName);
    featurecached=true;
    data=dlmread(cachefeatureFName);
    Y=data(:,1);
    F=data(:,2:end);
else

    if(~exist('cache','var'))
        cache=zeros(1,2);
    end

    if(~cache(1,1))%cache normized image
        [Y, X]=readmatrix(normimgFName,n,normSideLength,normSideLength);
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
        load(featureextracterFName);
        fe.copy(featureextracter);
    end

    if(~cache(1,2) || featureextracterchanged)%cache feature
        F=fe.extract(X);
        if(isTraining)
            featureextracter=fe.saveobj;
            save(featureextracterFName,'featureextracter');
        end
        dlmwrite(cachefeatureFName,[Y F]);
        cache(1,2)=true;
    end
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

