classdef EigenClassifier < Classifier
properties (SetAccess = private)
    model;
    classMean;
end
methods
    function this=EigenClassifier(d,categNum)
        this.d=d;
        this.categNum=categNum;
        this.classMean=zeros(this.categNum,d);
    end
    function train(this,Y,F)
        this.model=[Y F];
    end
    function pred=classifyOne(this,f)
        m=this.d^2;
        minInd=-1;
        for c=1:this.categNum
            distance=norm(this.classMean(c,:)-f);
            if(distance<m)
                m=distance;
                minInd=c;
            end
        end
        pred=minInd;
%         n=size(this.model,1);
%         min=size(this.model,2)^2;
%         minInd=0;
%         for i=1:n
%             distance=norm(this.model(i,2:end)-f);
%             if(distance<min)
%                 min=distance;
%                 minInd=i;
%             end
%         end
%         pred=this.model(minInd,1);
    end
    function S = saveobj(this)
        S.d=this.d;
        S.categNum=this.categNum;
        S.model=this.model;
    end
    function copy(this,S)
        this.d=S.d;
        this.categNum=S.categNum;
        this.model=S.model;
        
        F=this.model(:,2:end);
        Y=this.model(:,1);
        for c=1:this.categNum
            Fc=F(Y==c,:);
            this.classMean(c,:)=mean(Fc,1);
        end
    end
end
end