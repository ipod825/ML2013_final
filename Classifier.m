classdef Classifier < handle
   properties (SetAccess = public)
        d;
        categNum;
   end
methods
    function this = Classifier()
    end
    
    function train(this,Y,F)
    end

    function pred=classify(this,F)
        h = waitbar(0,'Testing...');
        n=size(F,1);
        pred=zeros(n,1);
        for i=1:n
            pred(i)=this.classifyOne(F(i,:));
            waitbar(i/n);
        end
        close(h);
    end
    
    function calssifyOne(this,f)
    end
end % methods
end % classdef