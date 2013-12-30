classdef Classifier < handle
   properties (SetAccess = public)
        d;
        categNum;
   end
methods
    function this = Classifier()
    end
    
    function train(this,Y,F)
    end

    function pred=classify(this,F)
        h = waitbar(0,'Testing...');
        n=size(F,1);
        pred=zeros(n,1);
        for i=1:n
            pred(i)=this.classifyOne(F(i,:));
            waitbar(i/n);
        end
        close(h);
    end
    
    function calssifyOne(this,f)
    end
    
    function Eval=crossvalidation(this,Y,X,fold)
        n=size(Y,1);
        leaveNum=floor(n/fold);
        % inds = uniformArray(n,1,n);
        inds=1:n;
        groups=zeros(n,1);
        group=0;
        for i=1:n
            if mod(i,leaveNum)==1 && group<fold
                group=group+1;
            end
            groups(inds(i))=group;
        end

        Eval=0;
        for i=1:fold
            trainInds=find(groups~=i);
            testInds=find(groups==i);
            clear cls;
            this.train(Y(trainInds,1),X(trainInds,:));
            pred=this.classify(X(testInds,:));
            Eval=Eval+(size(find(Y(testInds)~=pred))/size(testInds,1));
        end
        Eval=Eval/fold;
    end
end % methods
end % classdef