global categNum normSideLength isTraining featureFname n 
isTraining=true;
GLOBALVAR;


if(~exist('cache','var'))
    cache=zeros(1,2);
end

if(~cache(1,1))
    [Y, X]=readmatrix(featureFname,n,normSideLength,normSideLength);
    X=full(X);
    cache(1,1)=true;
end

    FE=2;
if(~cache(1,2))
    clear fe; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.
    switch(FE)
        case 1
            fe=DEFeatureExtracter(normSideLength,categNum);
        case 2
            pcafortrain=true;
            try %test
                eigenVec=dlmread('PCAEigenVecs.mat');
                fe=EigeneatureExtracter(floor(normSideLength*normSideLength/20),eigenVec);
                pcafortrain=false;
            catch e %train
                fe=EigenFeatureExtracter(floor(normSideLength*normSideLength/20),[]);
            end
    end
    F=fe.extract(X);
    if(pcafortrain)
        dlmwrite('PCAEigenVecs.mat',fe.eigenVec);
    end
    
    cache(1,2)=true;
end


clear cls; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.

CLS=2;
switch(CLS)
    case 1
       cls=AMDClassifier(size(F,2),categNum);
    case 2
       cls=SVMClassifier(size(F,2),categNum);
end



cls.train(Y,F);
classifier=cls.saveobj;
save('classifier.mat','classifier');


%below for cross validation
% fold=5;
% leaveNum=floor(n/fold);
% % inds = uniformArray(n,1,n);
% inds=1:n;
% groups=zeros(n,1);
% group=0;
% for i=1:n
%     if mod(i,leaveNum)==1 && group<fold
%             group=group+1;
%     end
%     groups(inds(i))=group;
% end
% 
% Eval=0;
% for i=1:fold
%     trainInds=find(groups~=i);
%     testInds=find(groups==i);
%     clear cls;
%     cls=AMDClassifier(fe.d,categNum);
%     cls.train(Y(trainInds,1),F(trainInds,:));
%     Eval=Eval+mytest(cls,Y(trainInds),F(trainInds));
% end
% Eval=Eval/fold;
