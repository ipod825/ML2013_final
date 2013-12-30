classdef SVMClassifier < Classifier
properties (SetAccess = private)
    model;
    gamma;
    C;
end
methods
    function this=SVMClassifier(d,categNum,gamma,C)
        setParameterDefault('gamma',0.1);
        setParameterDefault('C',0.1);
        this.d=d;
        this.categNum=categNum;
        this.gamma=gamma;
        this.C=C;
    end
    function train(this,Y,F)
        svmoptions=sprintf('-s 0 -t 2 -g %f -c %f -q',this.gamma, this.C);
        this.model=svmtrain(Y, F, svmoptions);
    end
    function pred=classify(this,F)
        pred = sign(svmpredict(zeros(size(F,1),1), F, this.model,'-q'));
    end
    function S = saveobj(this)
        S.d=this.d;
        S.categNum=this.categNum;
        S.model=this.model;
        S.gamma=this.gamma;
        S.C=this.C;
    end
    function copy(this,S)
        this.d=S.d;
        this.categNum=S.categNum;
        this.model=S.model;
        this.gamma=S.gamma;
        this.C=S.C;
    end
end
end