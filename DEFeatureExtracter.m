classdef DEFeatureExtracter<FeatureExtracter

properties (SetAccess = private)
    sideLen=0;
    halfWinLen=0;
    offStep=0;
    winLen=0;
    winNum=0;    
end


methods

    function this=DEFeatureExtracter(sideLen,categNum)
        this.winLen=2*sideLen/8;
        this.halfWinLen=sideLen/8;
        this.offStep=this.halfWinLen/4;
        this.sideLen=sideLen;%+this.winLen;
        this.winNum=((this.sideLen-this.halfWinLen)/this.halfWinLen)^2;
        this.d=this.winNum*4;
        this.categNum=categNum;
    end
    
    function f=extractOne(this,x)
        global normSideLength
        GLOBALVAR;
        x=reshape(x,normSideLength,normSideLength);
%         x=this.padding(x,size(x,1)+4);
        x=edge(x,'log');
%         x=this.contour(x);
%         x=this.padding(x,this.sideLen);
%             imshow(x);
        dirMatrix=this.calcDirection(x);
        f=this.constructFeatureVector(dirMatrix);
    end
    
    function f=constructFeatureVector(this,dirM)
        winBegs=1:this.halfWinLen:size(dirM,2)-this.winLen+1;
        winInd=1;
        winScore=zeros(4,this.winNum);
        for top=winBegs
            bottom=top+this.winLen-1;
            for left=winBegs
                right=left+this.winLen-1;

                for d=1:4               %different direction
                    lastScore=0;
                    offset=3*this.offStep;
                    for s=4:-1:1       %different sub-area
                        score=sum(sum(dirM(d,top+offset:bottom-offset,left+offset:right-offset)));
                        winScore(d,winInd)=winScore(d,winInd)+s*(score-lastScore);
                        lastScore=score;
                        offset=offset-this.offStep;
                    end
                end
                winInd=winInd+1;
            end
        end
        f=reshape(winScore,1,this.winNum*4);
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