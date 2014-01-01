%USAGE
%In the file you want to add some global variables in this file, write:
% global height width .... %<- declare global variables you need 
% GLOBALVAR; %<-initialzie the variables

global height width categNum normSideLength isTraining dataFname n rawdataFName featureFname cachefeatureFName 
global gamma C eigenValThred fold binThredshold FE CLS 
height = 122;
width = 105;
categNum=12;
%1:DEFeatureExtracter(normSideLength,categNum);
%2:EigenFeatureExtracter(eigenValThred,[]);
%3:WeightFeatureExtracter(normSideLength, categNum);
FE=1;
%1:cls=AMDClassifier(size(F,2),categNum);
%2:cls=SVMClassifier(size(F,2),categNum);
%3:cls=KNNClassifier(size(F,2),categNum);
%4:cls=NaieveBayesClassifier(size(F,2),categNum);
%5:cls=DecisionTreeClassifier(size(F,2),categNum);
CLS=2;

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
    featureFname='./featuretrain.dat';
    cachefeatureFName='./cachefeaturetrain.dat';
    rawdataFName='./ml2013final_train.dat';
else
    n=3072;
    dataFname='./mltest_sparse.dat';
    featureFname='./featuretest.dat';
    cachefeatureFName='./cachefeaturetest.dat';
    rawdataFName='./test1.dat';
end
