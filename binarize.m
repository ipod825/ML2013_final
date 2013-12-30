function ret=binarize(img,thredshold)
%BINARIZE sets pixels of img to 1(white) if origin value >thredshold, otherwise to 0(black)
setParameterDefault('thredshold',-1);
global binThredshold
GLOBALVAR;

    if(thredshold<0)
        thredshold=binThredshold;
    end
    ret=img;
    ret(img>thredshold)=1;
    ret(img<thredshold)=0;
end
