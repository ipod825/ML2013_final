%USAGE
%In the file you want to add some global variables in this file, write:
% global height width .... %<- declare global variables you need 
% GLOBALVAR; %<-initialzie the variables

global height width categNum normSideLength isTraining dataFname n...
    rawdataFName normimgFName cachefeatureFName featureextracterFName classifierFName...
    featureextracterchanged
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
C=0.1;
%% PCA
eigenValThred=50;
%%

%isTraining should be set by main program
if(isTraining)
    n=6132;    
    dataFname='./mltrain_sparse.dat';
    normimgFName='./normimgtrain.dat';
    cachefeatureFName='./cachefeaturetrain_';
    rawdataFName='./ml2013final_train.dat';
else
    n=3072;
    dataFname='./mltest_sparse.dat';
    normimgFName='./normimgtest.dat';
    cachefeatureFName='./cachefeaturetest_';
    rawdataFName='./test1.dat';
end

tmp=2;
if(FE~=tmp)
    featureextracterchanged=true;
else
    featureextracterchanged=false;
end
FE=tmp;
switch(FE)
    case 1
        fesufix='DE';
    case 2
        fesufix='Eigen';
    case 3
        fesufix='Weiget';
end
cachefeatureFName=[cachefeatureFName fesufix '.dat'];
featureextracterFName=['./featureextarcter_' fesufix '.mat'];

CLS=6;
switch(FE)
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
    case 5
        clssuffix='Discriment';
end
classifierFName=['./classifier_' clssuffix '.mat'];