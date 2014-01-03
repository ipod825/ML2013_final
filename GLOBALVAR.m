%USAGE
%In the file you want to add some global variables in this file, write:
% global height width .... %<- declare global variables you need 
% GLOBALVAR; %<-initialzie the variables

global height width categNum normSideLength isTraining dataFname n featurecached Fesuffix fecompoundind...
    rawdataFName normimgFName cachefeatureFName featureextracterFName classifierFName...
    compoundCachefeatureFName compoundFeatureextracterFName
    
global gamma C eigenValThred fold binThredshold FE CLS 
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
gamma=0.1;
C=100;
%% PCA
eigenValThred=0.8;
%%

%isTraining should be set by main program
if(isTraining)
    n=6133;        
    dataFname='./mltrain_sparse.dat';
    normimgFName='./normimgtrain.dat';
    cachefeatureFName='cachefeaturetrain_';
    rawdataFName='./ml2013final_train.dat';
else
    n=3072;
    dataFname='./mltest_sparse.dat';
    normimgFName='./normimgtest.dat';
    cachefeatureFName='cachefeaturetest_';
    rawdataFName='./test1.dat';
end

%%
tmp=6;%change this for FE
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
    compoundCachefeatureFName{1,i}=strcat(cachefeatureFName,Fesuffix(fecompoundind(i)),'.dat');
    compoundFeatureextracterFName{1,i}=strcat('featureextarcter_',Fesuffix(fecompoundind(i)),'.mat');
end

cachefeatureFName=[ cachefeatureFName fesuffix  '.dat'];
featureextracterFName=[ 'featureextarcter_' fesuffix '.mat'];


%%
CLS=6;
switch(CLS)
    case 1
        clssuffix='AMD';
    case 2
        clssuffix='SVM';
    case 3
        clssuffix='KNN';
    case 4
        clssuffix='NaieveBayes';
    case 5
        clssuffix='DecisionTree';
    case 6
        clssuffix='Discriment';
    case 7
        clssuffix='Boost';
    case 8
        clssuffix='Compound';
end
classifierFName=[ 'classifier_' clssuffix '.mat'];
