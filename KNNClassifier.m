classdef KNNClassifier < Classifier
properties (SetAccess = private)
    Y;
    F;
    k;
    p;
    
end
methods
    function this=KNNClassifier(d,categNum,k,p)
        this.d=d;
        this.categNum=categNum;
        this.k;
        this.p=p;
    end
    function train(this,Y,F)
        this.Y=Y;
        this.F=F;
    end
    function pred=classify(this,F)
        voter=10;
        pred = knnsearch(this.F,F,'k',10,'distance','minkowski','p',5);
%         pred = knnsearch(this.F,F,'k',10,'distance','mahalanobis');
        pred=mode(pred,2);
%         pred=pred(:,1);
        pred=this.Y(pred);
    end
        function S = saveobj(this)
        S.d=this.d;
        S.categNum=this.categNum;
        S.Y=this.Y;
        S.F=this.F;
    end
    function copy(this,S)
        this.d=S.d;
        this.categNum=S.categNum; 
        this.Y=S.Y;
        this.F=S.F;
    end
end
end