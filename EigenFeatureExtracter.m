classdef EigenFeatureExtracter < FeatureExtracter
    properties (SetAccess = public)
        pcdim;
        eigenValueSumThred;
        eigenVec;
        mVec;
    end
    methods
        function S = saveobj(this)
        % Save property values in struct
        % Return struct for save function to write to MAT-file
            S.pcdim=this.pcdim;
            S.eigenValueSumThred=this.eigenValueSumThred;
            S.eigenVec=this.eigenVec;
            S.mVec=this.mVec;
        end
        function copy(this,S)
        % Method used to assign values from struct to properties
            this.pcdim=S.pcdim;
            this.eigenValueSumThred=S.eigenValueSumThred;
            this.eigenVec=S.eigenVec;
            this.mVec=S.mVec;
        end
        function this=EigenFeatureExtracter(eigenValueSumThred,eigenVec)
            if(eigenValueSumThred<=1)
                this.eigenValueSumThred=eigenValueSumThred;
                this.pcdim=-1;
            else
                this.pcdim=eigenValueSumThred;
            end
            this.eigenVec=eigenVec;
        end
            
        function F=extract(this,X) %overwrite
            if(isempty(this.eigenVec))
                this.mVec=mean(X,1);
                [this.eigenVec F eigenvalues]= princomp(X);
                if(this.pcdim<0)
                    s=0;
                    S=sum(eigenvalues);
                    for i=1:size(eigenvalues,1)
                        s=s+eigenvalues(i);
                        if(s/S>this.eigenValueSumThred)
                            this.pcdim=i;
                            break;
                        end
                    end
                end
                F=F(:,1:this.pcdim);
                this.eigenVec=this.eigenVec(:,1:this.pcdim);
            else
                F=(X-repmat(this.mVec,size(X,1),1))*this.eigenVec;
            end
        end
    end
end