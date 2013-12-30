%USAGE
%In the file you want to add some global variables in this file, write:
% global height width .... %<- declare global variables you need 
% GLOBALVAR; %<-initialzie the variables

global height width categNum normSideLength isTraining dataFname n rawdataFName featureFname
global gamma C pcdim fold binThredshold
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
pcdim=200;
%%

%isTraining should be set by main program
if(isTraining)
    n=6132;    
    dataFname='./mltrain_sparse.dat';
    featureFname='./featuretrain.dat';
    rawdataFName='./ml2013final_train.dat';
else
    n=3072;
    dataFname='./mltest_sparse.dat';
    featureFname='./featuretest.dat';
    rawdataFName='./test1.dat';
%     n=6132;    
%     dataFname='./mltrain_sparse.dat';
%     featureFname='./featuretrain.dat';
%     rawdataFName='./ml2013final_train.dat';
end