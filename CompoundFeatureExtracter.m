classdef CompoundFeatureExtracter < FeatureExtracter
properties
    numExtracters;
    extracters;
end


methods
    function S = saveobj(this)
    % Save property values in struct
    % Return struct for save function to write to MAT-file
        S.extracters=cell(1,size(this.extracters,2));
        for i=1:this.numExtracters
            S.extracters{1,i}=this.extracters{1,i}.saveobj;
        end
    end
    function copy(this,S)
    % Method used to assign values from struct to properties
        for i=1:this.numExtracters
            this.extracters{1,i}.copy(S.extracters{1,i}); 
        end    
    end
    function this=CompoundFeatureExtracter(extracters)
        this.numExtracters=size(extracters,2);
        this.extracters=extracters;
    end
    function F=extract(this,X)
        F=[];
        for i=1:this.numExtracters
            F=[F this.extracters{1,i}.extract(X)];
        end
    end
    function w=getDimension(this)
        w=zeros(1,this.numExtracters);
        for i=1:this.numExtracters
            w(i)=this.extracters{1,i}.d;
        end
    end
end
end