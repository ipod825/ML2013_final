function ret=normalizeImg(img)
%NORMALIZEIMAGE normalize the input image. The sidelength of the normalized image is set to 64(default).
%ASAN(http://link.springer.com/chapter/10.1007%2F3-540-40063-X_55#page-1) is implemented for better performance
    global normSideLength
    GLOBALVAR;
    setParameterDefault('sideLen','-1');
    sideLen=normSideLength;
    img=sparse2full(img);
    h=size(img,1);
    w=size(img,2);
    
    img=medfilt2(img,[3,3]);
    img=binarize(img);
    img(1:2,:)=0; img(h-1:h,:)=0;
    img(:,1:2)=0; img(:,w-1:w)=0;

    ret=zeros(sideLen);
    top=0;bottom=0;left=0;right=0;
    for r=1:h
        if(~isempty(find(img(r,:), 1))) top=r; break; end
    end
    for r=h:-1:1
        if(~isempty(find(img(r,:), 1))) bottom=r; break; end
    end
    for c=1:w
        if(~isempty(find(img(:,c), 1))) left=c; break; end
    end
    for c=w:-1:1
        if(~isempty(find(img(:,c), 1))) right=c; break; end
    end
    
    if(top==0 || bottom==0 || left==0 || right==0)
        return;
    end
    %ori is the crop image of img
    Wori=right-left+1;
    Hori=bottom-top+1;
    Iori=img(top:bottom,left:right);
    
    WgeH=true; %Wori>=Hori
    Rori=Hori/Wori;
    if(Wori<Hori)
        WgeH=false;
        Rori=Wori/Hori;
    end
   
    Rnorm=sqrt(sin(pi*Rori/2));
    Wnorm=sideLen;
    Hnorm=sideLen;
    roffset=0;
    coffset=0;
    
    if(WgeH)
        Hnorm=floor(Wnorm*Rnorm);    
        roffset=floor((sideLen-Hnorm)/2);
    else
        Wnorm=floor(Hnorm*Rnorm);
        hoffset=floor((sideLen-Wnorm)/2);
    end

    for r=1:Hnorm
        for c=1:Wnorm
            rori=ceil(Hori*(r/Hnorm));
            cori=ceil(Wori*(c/Wnorm));
            ret(r+roffset,c+coffset)=Iori(rori,cori);
        end
    end   
%     ret=denoise(ret);
end



%%inverse warping, not quite good
%     for r=1:Hnorm
%         for c=1:Wnorm
%             rori=Hori*(r/Hnorm);
%             cori=Wori*(c/Wnorm);
%             lef=floor(cori);
%             top=floor(rori);
%             rig=lef+1;
%             bot=top+1;
%             rd=rori-top;
%             cd=cori-c;
%             if lef<1
%                 lef=1;
%             end
%             if top<1
%                 top=1;
%             end
%             if bot>Hori 
%                 bot=Hori;
%             end;
%             if rig>Wori 
%                 rig=Wori; 
%             end;
%             ret(r+roffset,c+coffset)=(1-rd)*(1-cd)*Iori(top,lef)+rd*cd*Iori(bot,rig)+...
%                                      (1-rd)*cd*Iori(bot,lef)+rd*(1-cd)*Iori(top,rig);
%         end
%     end
