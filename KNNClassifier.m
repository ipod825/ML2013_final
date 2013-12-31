classdef KNNClassifier < Classifier
properties (SetAccess = private)
    Y;
    F;
end
methods
    function this=KNNClassifier(d,categNum)
        this.d=d;
        this.categNum=categNum;
    end
    function train(this,Y,F)
        this.Y=Y;
        this.F=F;
    end
    function pred=classify(this,F)
        pred = knnsearch(this.F,F,'k',10,'distance','minkowski','p',5);
        pred=pred(:,1);
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