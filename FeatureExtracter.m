classdef FeatureExtracter <handle
    properties (SetAccess = public)
        d;
        categNum;
    end
    methods
        function this=FeatureExtracter()
        end
        function F=extract(this,X)
            n=size(X,1);
            F=zeros(size(X,1),this.d);
            h = waitbar(0,'Feature Extraction...');
            for i=1:n
                F(i,:)=this.extractOne(X(i,:));
                waitbar(i / n);
            end
            close(h);
        end
        
        function f=extractOne(this,x)
        end
    end
end