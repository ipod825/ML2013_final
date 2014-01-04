classdef DEFeatureExtracter<FeatureExtracter

properties (SetAccess = private)
    sideLen=0;
    winDim=0;
    winLen=0;
    winNum;
    numFeaturePerWin;   
end


methods
    function this = DEFeatureExtracter(sideLen, categNum,eigenValueSumThred)
        this.sideLen = sideLen;
        this.winDim=4;
        this.winLen=this.sideLen/this.winDim;
        this.winNum=this.winDim^2;
        this.d=this.winNum*4*4;
        this.categNum = categNum;
    end
    function S = saveobj(this)
        % Save property values in struct
        % Return struct for save function to write to MAT-file
        S.sideLen=this.sideLen;
        S.winLen=this.winLen;
        S.winNum=this.winNum;
        S.d = this.d;
        S.categNum = this.categNum;
    end
    function copy(this,S)
    % Method used to assign values from struct to properties
          this.sideLen=S.sideLen;
          this.winLen=S.winLen;
          this.winNum=S.winNum;
          this.d = S.d;
          this.categNum = S.categNum;
    end
    
    function f=extractOne(this,x)
        x=reshape(x,this.sideLen,this.sideLen);
        x = bwmorph(x, 'thin', Inf);
        imshow(x);
%         x=this.padding(x,size(x,1)+4);
        x=edge(x,'log');
%         x=this.contour(x);
%         x=this.padding(x,this.sideLen);
%         imshow(x);
        dirMatrix=this.calcDirection(x);
        f=this.constructFeatureVector(dirMatrix);
    end
    
    function f=constructFeatureVector(this,dirM)
        beg = this.winLen*(0:this.winDim);
        f= zeros(this.winDim,4);
        winInd=1;
        for i = 1 : this.winDim
            for j = 1 : this.winDim
                for k=1:4
                    subArea = dirM(k,beg(i)+1:beg(i+1), beg(j)+1:beg(j+1));
                    f(winInd, 4) = sum(sum(subArea(1,:,:)));
                    winInd=winInd+1;
                end
            end
        end
        f=reshape(f,1,this.d);
    end
    
    function ret=padding(this, img, newSideLength)
    %Add extra pixels so that the sideLen of the image become newSideLength
        ret=zeros(newSideLength);
        roffset=(newSideLength-size(img,1))/2;
        coffset=(newSideLength-size(img,2))/2;
        ret(roffset+1:size(img,1)+roffset,coffset+1:size(img,2)+coffset)=img;
    end
    
    function ret=contour(this,img)
        ret=img;
        [R,C]=ind2sub(size(img),find(img==0));
        for i=1:size(R,1)
            r=R(i,1);c=C(i,1);
            if(r==1 || c==1 || r==size(img,1) ||  c==size(img,2))
                continue;
            end
            if(img(r-1,c)>0 || img(r+1,c)>0 || img(r,c-1)>0 || img(r,c+1)>0 )
                ret(r,c)=1;
            end
        end
        ret=ret-img;
    end
    
    function dirM=calcDirection(this,img)
        %1:vertical, 2:horizontal, 3:leftiup2rightdown 4:rightup2leftdown
        dirM=zeros(4,this.sideLen,this.sideLen);
        [R,C]=ind2sub(size(img),find(img));
        
        for i=1:size(R,1)
                r=R(i,1);c=C(i,1);
                if(img(r-1,c)>0 || img(r+1,c)>0)
                    dirM(1,r,c)=dirM(1,r,c)+1;
                end
                if(img(r,c-1)>0 || img(r,c+1)>0)
                    dirM(2,r,c)=dirM(2,r,c)+1;
                end
                if(img(r-1,c-1)>0 || img(r+1,c+1)>0)
                    dirM(3,r-1,c-1)=dirM(3,r+1,c+1)+1;
                end
                if(img(r-1,c+1)>0 || img(r+1,c-1)>0)
                    dirM(4,r-1,c+1)=dirM(4,r+1,c-1)+1;
                end
        end
    end
    
    
end
end