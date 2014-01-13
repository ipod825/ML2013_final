classdef TextureFeatureExtracter < FeatureExtracter

properties (SetAccess = private)
    sideLen=0;
    winDim=0;
    winLen=0;
    winNum;
    numFeaturePerWin;
    freqNum;
    filters;
%     pca;
end

methods
    function this = TextureFeatureExtracter(sideLen, categNum,eigenValueSumThred)
        this.sideLen = sideLen;
        this.winDim=4;
        this.winLen=this.sideLen/this.winDim;
        this.winNum=this.winDim^2;
        this.freqNum=4;
        var=5;
        this.d=this.winNum*this.freqNum;
        this.filters=cell(1,this.freqNum);
        f=pi/2;
        for i=1:this.freqNum
            this.filters{1,i}=gaborfilter2(var,var,f,(i-1)*pi/this.freqNum);
        end
        this.categNum = categNum;

%         this.pca=PcaWrapper(eigenValueSumThred,[]);
    end
    function S = saveobj(this)
        % Save property values in struct
        % Return struct for save function to write to MAT-file
        S.sideLen=this.sideLen;
        S.winLen=this.winLen;
        S.winNum=this.winNum;
        S.d = this.d;
        S.categNum = this.categNum;
%         S.pca=this.pca.saveobj;
    end
    function copy(this,S)
    % Method used to assign values from struct to properties
          this.sideLen=S.sideLen;
          this.winLen=S.winLen;
          this.winNum=S.winNum;
          this.d = S.d;
          this.categNum = S.categNum;
%           this.pca.copy(S.pca);
    end
    
    function F=extract(this,X)
        n=size(X,1);
        F=zeros(size(X,1),this.d);
        h = waitbar(0,'Feature Extraction...');
        for i=1:n
            a=this.extractOne(X(i,:));
            F(i,:)=a;
            waitbar(i / n);
        end
%         F=this.pca.extract(F);
        close(h);
    end
    
    function f=extractOne(this,x)
        x=reshape(x,this.sideLen,this.sideLen);
        gaborImgs = this.getGaborImg(x);
        f=[];
        for i=1:this.freqNum
            df=this.getDensityVector(gaborImgs{1,i});
            f=[f df];
        end
    end
    
    function ret = getGaborImg(this,img)
        ret=cell(1,this.freqNum);
%         img = bwmorph(img, 'clean');
%         img = bwmorph(img, 'majority');
        img = bwmorph(img, 'thin', Inf);

        f = pi/2;
        for i=1:this.freqNum
            gaborImg=conv2(double(img),double(real(this.filters{i})),'same');
            gaborImg=sqrt(gaborImg.*gaborImg);
            ret{1,i}=imresize(gaborImg,[this.sideLen,this.sideLen]);
        end
    end
    
    function f=getDensityVector(this,img)
        beg = this.winLen*(0:this.winDim);
        f= zeros(this.winDim);
        for i = 1 : 4
            for j = 1 : 4
                subArea = img(beg(i)+1:beg(i+1), beg(j)+1:beg(j+1));
                f(i, j) = sum(sum(subArea));
            end
        end
        f=reshape(f,1,this.winNum);
    end
end
end