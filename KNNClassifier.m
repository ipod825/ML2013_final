classdef KNNClassifier < WrapClassifier

methods
    function this=KNNClassifier(d,categNum)
        this.d=d;
        this.categNum=categNum;
    end
    function pred=classify(this,F)
        pred = knnsearch(this.F,F,'k',10,'distance','minkowski','p',5);
        pred=pred(:,1);
        pred=this.Y(pred);
    end
end
end