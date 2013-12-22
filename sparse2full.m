function ret=sparse2full(A,height,width)
%SPARSE2FULL convert original matrix to full matrix of a certain default
%dimension (height, width)
    if(~issparse(A))
        ret=A;
    else
        setParameterDefault('height',122);
        setParameterDefault('width',105);
        ret=full(reshape(A,width,height));
    end
end