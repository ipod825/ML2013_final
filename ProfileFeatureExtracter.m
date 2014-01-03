classdef ProfileFeatureExtracter < FeatureExtracter

properties (SetAccess = private)
    sideLen=0;
end

methods
    function this = ProfileFeatureExtracter(sideLen, categNum)
        this.sideLen = sideLen;
        this.categNum = categNum;
        this.d=4*this.sideLen;
    end
    function S = saveobj(this)
        % Save property values in struct
        % Return struct for save function to write to MAT-file
        S.d = this.d;
        S.sideLen = this.sideLen;
        S.categNum = this.categNum;
    end
    function copy(this,S)
    % Method used to assign values from struct to properties
          this.d = S.d;
          this.sideLen=S.sideLen;
          this.categNum = S.categNum;
    end
    
    function f=extractOne(this,x)
        x=reshape(x,this.sideLen,this.sideLen);
        topp=zeros(1,this.sideLen);
        bottomp=zeros(1,this.sideLen);
        leftp=zeros(1,this.sideLen);
        rightp=zeros(1,this.sideLen);
        for i=1:this.sideLen
            row=x(i,:);
            col=x(:,i);
            [~, rind]=find(row);
            [~, cind]=find(col);
            if(~isempty(rind))
                topp(i)=rind(1);
                bottomp(i)=rind(end);
            end
            if(~isempty(cind))
                leftp(i)=cind(1);
                rightp(i)=cind(end);
            end
        end
        f=[topp bottomp leftp rightp];
    end
end % method end

end % class end