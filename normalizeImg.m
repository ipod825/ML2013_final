function ret=normalizeImg(img,normSideLength)
%NORMALIZEIMAGE normalize the input image. The sidelength of the normalized image is set to 64(default).
%ASAN(http://link.springer.com/chapter/10.1007%2F3-540-40063-X_55#page-1) is implemented for better performance
    setParameterDefault('normSideLength',64);
    img=sparse2full(img);
    img=binarize(img);
    h=size(img,1);
    w=size(img,2);
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
    Wnorm=normSideLength;
    Hnorm=normSideLength;
    roffset=0;
    coffset=0;
    
    if(WgeH)
        Hnorm=floor(Wnorm*Rnorm);    
        roffset=floor((normSideLength-Hnorm)/2);
    else
        Wnorm=floor(Hnorm*Rnorm);
        hoffset=floor((normSideLength-Wnorm)/2)
    end
    
    ret=zeros(normSideLength);
    for r=1:Hnorm
        for c=1:Wnorm
            rori=ceil(Hori*(r/Hnorm));
            cori=ceil(Wori*(c/Wnorm));
            ret(r+roffset,c+coffset)=Iori(rori,cori);
        end
    end
    
    
end
