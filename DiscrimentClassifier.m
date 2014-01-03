classdef DiscrimentClassifier < WrapClassifier
methods
    function this=DiscrimentClassifier(d,categNum,weight)
        this.d=d;
        this.categNum=categNum;
    end
    function train(this,Y,F)
        this.model= ClassificationDiscriminant.fit(F,Y,'discrimType','pseudoQuadratic');
    end
end
end