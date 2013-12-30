classdef EigenFeatureExtracter < FeatureExtracter
    properties (SetAccess = public)
        pcdim;
        eigenVec;
        mVec;
    end
    methods
        function S = saveobj(this)
        % Save property values in struct
        % Return struct for save function to write to MAT-file
            S.pcdim=this.pcdim;
            S.eigenVec=this.eigenVec;
            S.mVec=this.mVec;
        end
        function copy(this,S)
        % Method used to assign values from struct to properties
            this.pcdim=S.pcdim;
            this.eigenVec=S.eigenVec;
            this.mVec=S.mVec;
        end
        function this=EigenFeatureExtracter(pcdim,eigenVec)
            this.pcdim=pcdim;
            this.eigenVec=eigenVec;
        end
            
        function F=extract(this,X) %overwrite
            if(isempty(this.eigenVec))
                this.mVec=mean(X,1);
                [this.eigenVec F]= princomp(X);
                F=F(:,1:this.pcdim);
                this.eigenVec=this.eigenVec(:,1:this.pcdim);
            else
                F=(X-repmat(this.mVec,size(X,1),1))*this.eigenVec;
            end
        end
    end
end