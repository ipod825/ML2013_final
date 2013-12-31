classdef DecisionTreeClassifier < WrapClassifier
methods
    function this=DecisionTreeClassifier(d,categNum)
        this.d=d;
        this.categNum=categNum;
    end
    function train(this,Y,F)
        this.model= ClassificationTree.fit(F,Y);
    end
end
end