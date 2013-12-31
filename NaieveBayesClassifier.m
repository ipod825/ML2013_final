classdef NaieveBayesClassifier < WrapClassifier
methods
    function this=NaieveBayesClassifier(d,categNum)
        this.d=d;
        this.categNum=categNum;
    end
    function train(this,Y,F)
        this.model= NaiveBayes.fit(F,Y,'Distribution','kernel');
    end
end
end