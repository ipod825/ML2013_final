global n categNum  normSideLength isTraining  featurecached...
       normimgFName cachefeatureFName featureextracterFName
global FE CLS Fesuffix fecompoundind Clssuffix clscompoundind...
       compoundCachefeatureFName compoundFeatureextracterFName compoundClassifierFName clscompoundProb
global gamma C eigenValThred 
GLOBALVAR;  % Some global variables are set depends on the value of isTraining(set in trainmain.m or testmain.m)

if(~exist('Y','var'))   % check if normalized image has been loaded
    [Y, X]=readmatrix(normimgFName,n,normSideLength,normSideLength);
    X=full(X);
elseif(size(Y,1)~=n)    % check if the cached Y X F are not right(i.e cached training data when testing)
    [Y, X]=readmatrix(normimgFName,n,normSideLength,normSideLength);
    X=full(X);
    clear F;
    featurecached=false; 
end

clear fe; 
clear Fes;
Fes=cell(1,size(Fesuffix,2));
Fes{1,1}=DEFeatureExtracter(normSideLength,categNum);
Fes{1,2}=EigenFeatureExtracter(eigenValThred,[]);
Fes{1,3}=WeightFeatureExtracter(normSideLength, categNum);
Fes{1,4}=TextureFeatureExtracter(normSideLength, categNum,eigenValThred);
Fes{1,5}=ProfileFeatureExtracter(normSideLength, categNum);
Fes{1,6}=CompoundFeatureExtracter({Fes{fecompoundind}},compoundCachefeatureFName,compoundFeatureextracterFName);

fe=Fes{1,FE};
if(~isTraining) % for some feature extracter, we save some information at training and load it when testing
    load(featureextracterFName);
    fe.copy(featureextracter);
end

cachingFeatureOffline=true;
if(~exist('F','var') || ~featurecached) 
    if exist(cachefeatureFName,'file')
        warning('Using cached feature file: %s. Remove it if you have modified the featureextracter.',cachefeatureFName);
        data=dlmread(cachefeatureFName);
        F=data(:,2:end);
    else
        F=fe.extract(X);
        if(isTraining)
            featureextracter=fe.saveobj;
            save(featureextracterFName,'featureextracter');
        end
        if (cachingFeatureOffline)
            dlmwrite(cachefeatureFName,F);
        end
    end
    featurecached=true;
end

clear cls; 
clear Cls;
Cls=cell(1,size(Clssuffix,2));
Cls{1,1}=AMDClassifier(size(F,2),categNum);
Cls{1,2}=SVMClassifier(size(F,2),categNum,gamma,C);
Cls{1,3}=KNNClassifier(size(F,2),categNum);
Cls{1,4}=NaieveBayesClassifier(size(F,2),categNum);
Cls{1,5}=DecisionTreeClassifier(size(F,2),categNum);
Cls{1,6}=DiscrimentClassifier(size(F,2),categNum);
Cls{1,7}=BoostClassifier(size(F,2),categNum);
Cls{1,8}=CompoundClassifier({Cls{clscompoundind}},compoundClassifierFName,clscompoundProb);
cls=Cls{1,CLS};