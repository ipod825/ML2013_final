classdef WrapClassifier < Classifier
properties (SetAccess = public)
    model;
end
methods
    function this=WrapClassifier()
    end
    function train(this,Y,F)
    end
    function pred=classify(this,F)
        pred=predict(this.model,F);
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
    end
end
end