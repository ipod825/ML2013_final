function [r,c]=transInd(pos)
    r=(pos-1)/105;
    c=mod((pos-1), 105);
end