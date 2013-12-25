global categNum normSideLength isTraining featureFname n 
isTraining=true;
GLOBALVAR;
[Y, X]=readmatrix(featureFname,n,normSideLength,normSideLength);
X=full(X);

clear fe; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.
fe=DEFeatureExtracter(normSideLength,categNum);

F=zeros(n,fe.d);
h = waitbar(0,'Feature Extraction...');
for i=1:n
    img=reshape(X(i,:),normSideLength,normSideLength);
    F(i,:)=fe.extract(Y(i),img);
    waitbar(i / n);
end
close(h);
% dlmwrite('trainFeature.mat',F)
% dlmwrite('trainLabel.mat',Y)
% F=dlmread('trainFeature.mat');
% Y=dlmread('trainLabel.mat');

clear cls; %Use this when debugging. When you have modified the class file, you need to reinitial the class instance.
cls=AMDClassifier(size(F,2),categNum);
cls.train(Y,F);
cls=cls.saveobj;
save('cls.mat','cls');


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
