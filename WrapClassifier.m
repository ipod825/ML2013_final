classdef WrapClassifier < Classifier
properties (SetAccess = public)
    Y;
    F;
end
methods
    function this=WrapClassifier()
    end
    function train(this,Y,F)
        this.Y=Y;
        this.F=F;
    end
    function pred=classify(this,F)
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