function [Y,X, height, width] = readmatrix(nBeg, nEnd,filename)
% READFILE read from training data
% [Y,X, height, width] = readfile(nBeg, nEnd,filename)
%   Output:
%   Y: labels array
%   X: image sparse matrix
%   height: height of image
%   width: width of image

    setParameterDefault('filename','./mltrain_sparse.dat');
    setParameterDefault('nBeg',1);
    setParameterDefault('nEnd',6144);
    fd = fopen(filename);
    if(fd<0)
        error('%s not found. Please execute "translate" first to get the converted file',filename);
    end

    height = 122;
    width = 105;
    d = height*width;
    n=nEnd-nBeg+1;
    data=dlmread(filename);
    data=sparse(data(:,1),data(:,2),data(:,3),n,d+1);
    Y = data(nBeg:nEnd,1);
    X = data(nBeg:nEnd,2:end);
end
