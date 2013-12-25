classdef AMDClassifier < Classifier
properties (SetAccess = private)
    muhat;
    eigenVec;
    quasiPosVar;
    quasiNegVar;
end
methods
    
    function this=AMDClassifier(d,categNum)
        this.d=d;
        this.categNum=categNum;
        this.muhat=zeros(categNum,this.d);
        this.eigenVec=zeros(this.categNum,this.d,this.d);
        this.quasiPosVar=zeros(this.categNum,this.d);
        this.quasiNegVar=zeros(this.categNum,this.d);
    end

    function train(this,Y,F)
        for c=1:this.categNum
            catM=F(Y==c,:);
            mu=mean(catM);
            diffM=catM-repmat(mu,size(catM,1),1);
            [V, D]=eig(cov(catM),'nobalance');
%             D(D>-10^-4 & D<10^-4)=0;
            this.eigenVec(c,:,:)=V;
            quasiMu=zeros(1,this.d);
            D(D<0)=10^-20; %keep eigen value>0 since it is semi-definite
            for i=1:this.d
                evi=V(:,i);
                thred=3*sqrt(D(i,i));
                U=diffM*evi;
                S=U(U>-thred & U<thred);
                if(isempty(S)) S=[0]; end
                quasiMu(1,i)=mean(S)+mu*evi;
                Spos=U(U>=0 & U<=thred);
                if(isempty(Spos)) Spos=[0]; end
                this.quasiPosVar(c,i)=mean(Spos.*Spos);
                Sneg=U(U>=-thred & U<0);
                if(isempty(Sneg)) Sneg=[0]; end
                this.quasiNegVar(c,i)=mean(Sneg.*Sneg);
            end
            for i=1:this.d
                this.muhat(c,:)=this.muhat(c,:)+(quasiMu(1,i)*V(:,i))';
            end
        end
    end

    function categ=classify(this,f)
        distance=zeros(1,this.categNum);
        
        for c=1:this.categNum
            diff=f-this.muhat(c,:);
            for i=1:this.d
                evi=reshape(this.eigenVec(c,:,i),size(diff,2),1);
                proj=diff*evi;
                rho=this.quasiPosVar(c,i);
                if(proj<0)
                    rho=this.quasiNegVar(c,i);
                end
                distance(1,c)=distance(1,c)+(proj/rho)^2;
            end
        end
        [dumb, categ]=min(distance);
    end
    
    function S = saveobj(this)
    % Save property values in struct
    % Return struct for save function to write to MAT-file
        S.d=this.d;
        S.categNum=this.categNum;
        S.muhat=this.muhat;
        S.eigenVec=this.eigenVec;
        S.quasiPosVar=this.quasiPosVar;
        S.quasiNegVar=this.quasiNegVar;
    end
    function copy(this,S)
    % Method used to assign values from struct to properties
        this.d=S.d;
        this.categNum=S.categNum;
        this.muhat=S.muhat;
        this.eigenVec=S.eigenVec;
        this.quasiPosVar=S.quasiPosVar;
        this.quasiNegVar=S.quasiNegVar;
    end
end

end