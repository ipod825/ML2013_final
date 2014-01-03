%USAGE
%In the file you want to add some global variables in this file, write:
% global height width .... %<- declare global variables you need 
% GLOBALVAR; %<-initialzie the variables

global height width categNum normSideLength isTraining dataFname n...
    rawdataFName normimgFName cachefeatureFName featureextracterFName classifierFName...
    featurecached
global gamma C eigenValThred fold binThredshold FE CLS 
height = 122;
width = 105;
categNum=12;


%tunning
%% CrossValidation
fold=5;
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
tmp=4;%change this for FE
if(isempty(FE) || FE~=tmp)
    featurecached=false;
else
    featurecached=true;
end
FE=tmp;
switch(FE)
    case 1
        fesuffix='DE';
    case 2
        fesuffix='Eigen';
    case 3
        fesuffix='Weiget';
    case 4
        fesuffix='Texture';
    case 5
        fesuffix='Broken';
    case 6
        fesuffix='Profile';
    case 7
        fesuffix='Compound';
end
cachefeatureFName=[  cachefeatureFName fesuffix  '.dat'];
featureextracterFName=[ 'featureextarcter_' fesuffix '.mat'];

%%
CLS=2;
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
