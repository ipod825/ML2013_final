%USAGE
%In the file you want to add some global variables in this file, write:
% global height width .... %<- declare global variables you need 
% GLOBALVAR; %<-initialzie the variables
global height width  rawdataFName dataFname
global fold binThredshold
global classifierFName
global n categNum  normSideLength isTraining  featurecached...
       normimgFName cachefeatureFName featureextracterFName 
global FE CLS Fesuffix fecompoundind Clssuffix clscompoundind...
       compoundCachefeatureFName compoundFeatureextracterFName compoundClassifierFName clscompoundProb
global gamma C eigenValThred 
height = 122;
width = 105;
categNum=12;


%tunning
%% CrossValidation
fold=6;
%% Normalization
normSideLength=64;
binThredshold=0.06;
%% SVM
gamma=0.01;
C=40;
%% PCA
eigenValThred=50;
%% CompoundClassifier
clscompoundind=[2,6,6,2];%Clssuffix={'AMD';'SVM';'KNN';'NaieveBayes';'DecisionTree';'Discriment';'Boost';'Compound'};
auxclscompoundind=[4,4,2,2];%Fesuffix={'DE';'Eigen';'Weight';'Texture';'Profile';'Compound'};
% clscompoundProb=[0.9,0.87,0.81,0.79];
clscompoundProb=[0.1,0.6,0.3,0.2];


%isTraining should be set by main program
datadir='./data/';
mkdir(datadir);
if(isTraining)
%     n=6133; 
    n=9199;
%     n=12133;
    dataFname=strcat(datadir,'mltrain_sparse.dat');
    normimgFName=strcat(datadir,'normimgtrain.dat');
    cachefeatureFName='cachefeaturetrain_';
    rawdataFName=strcat(datadir,'ml2013final_train.dat');
else
    n=3072;
    dataFname=strcat(datadir,'mltest_sparse.dat');
    normimgFName=strcat(datadir,'normimgtest.dat');
    cachefeatureFName='cachefeaturetest_';
    rawdataFName=strcat(datadir,'test1.dat');
end

modeldir='./model/';
mkdir(modeldir);
%%
tmp=1;%change this for FE
fecompoundind=[4,5];
if(isempty(FE) || FE~=tmp)
    featurecached=false;
else
    featurecached=true;
end
FE=tmp;

Fesuffix={'DE';'Eigen';'Weight';'Texture';'Profile';'Compound'};
fesuffix=Fesuffix{FE};

compoundCachefeatureFName=cell(1,size(fecompoundind,2));
compoundFeatureextracterFName=cell(1,size(fecompoundind,2));
for i=1:size(fecompoundind,2)
    compoundCachefeatureFName{1,i}=strcat(modeldir,cachefeatureFName,Fesuffix(fecompoundind(i)),'.dat');
    compoundFeatureextracterFName{1,i}=strcat(modeldir,'featureextarcter_',Fesuffix(fecompoundind(i)),'.mat');
end

cachefeatureFName=strcat(modeldir,cachefeatureFName,fesuffix,'.dat');
featureextracterFName=strcat(modeldir,'featureextarcter_',fesuffix,'.mat');


%%
CLS=2;

Clssuffix={'AMD';'SVM';'KNN';'NaieveBayes';'DecisionTree';'Discriment';'Boost';'Compound'};
clssuffix=Clssuffix{CLS};

compoundClassifierFName=cell(1,size(clscompoundind,2));
for i=1:size(clscompoundind,2)
    compoundClassifierFName{1,i}=strcat(modeldir,'classifier_',Clssuffix(clscompoundind(i)),...
                                        '_',Fesuffix(auxclscompoundind(i)),'.mat');
end
if(strcmp(clssuffix,'Compound'))
    classifierFName=strcat(modeldir,'classifier_',clssuffix,'.mat');
else
    classifierFName=strcat(modeldir,'classifier_',clssuffix,'_',fesuffix,'.mat');
end