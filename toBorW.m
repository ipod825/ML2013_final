function ret=toBorW(img)
%TOBORW sets pixels of img to 1(white) if origin value >thredshold, otherwise to 0(black)
    thredshold=0.06;
    ret=img;
    ret(img>thredshold)=1;
    ret(img<thredshold)=0;
end