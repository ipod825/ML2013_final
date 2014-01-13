classdef CompoundFeatureExtracter < FeatureExtracter
properties
    numExtracters;
    extracters;
    cachefeatureFName
    featureextracterFName;
end

methods
    function S = saveobj(this)
    % Save property values in struct
    % Return struct for save function to write to MAT-file    
        S.numExtracters=this.numExtracters;
        S.featureextracterFName=this.featureextracterFName;
        for i=1:this.numExtracters
            featureextracter=this.extracters{1,i}.saveobj;
            save(char(this.featureextracterFName{1,i}),'featureextracter');
        end
    end
    function copy(this,S)
    % Method used to assign values from struct to properties
        this.numExtracters=S.numExtracters;
        this.featureextracterFName=S.featureextracterFName;
        for i=1:this.numExtracters
            load(char(S.featureextracterFName{1,i}));
            this.extracters{1,i}.copy(featureextracter);
        end    
    end
    function this=CompoundFeatureExtracter(extracters,cachefeatureFName,featureextracterFName)
        this.extracters=extracters;
        this.numExtracters=size(extracters,2);
        this.cachefeatureFName=cachefeatureFName;
        this.featureextracterFName=featureextracterFName;
    end
    function F=extract(this,X)
        F=[];
        for i=1:this.numExtracters
            cacheFName=char(this.cachefeatureFName{i});
            if exist(cacheFName,'file')
                warning('Using cached feature file: %s. Remove it if you have modified the featureextracter.',cacheFName);
                F=[F dlmread(cacheFName)];
            else
               data=this.extracters{1,i}.extract(X);
               F=[F data];
               dlmwrite(char(this.cachefeatureFName{1,i}),data);
            end
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