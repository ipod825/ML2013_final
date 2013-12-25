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

    function categ=classify(this,f)
    end
end % methods
end % classdef