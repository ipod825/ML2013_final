classdef BoostClassifier < Classifier
properties (SetAccess = private)
    model;
end
methods
    function this=BoostClassifier(d,categNum)
        this.d=d;
        this.categNum=categNum;
    end
    function train(this,Y,F)
        this.model = fitensemble(F,Y,'AdaBoostM2',100,'tree');
    end
    function pred=classify(this,F)
        pred = predict(this.model,F);
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

