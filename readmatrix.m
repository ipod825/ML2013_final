function [Y,X] = readmatrix(nBeg, nEnd,filename)
% READMATRIX read all data from the training file
% [Y,X] = readmatrix(filename)
%   Output:
%   Y: labels array
%   X: image sparse matrix
    global height width n
    GLOBALVAR;
    
    setParameterDefault('filename','./mltrain_sparse.dat');
    setParameterDefault('nBeg',1);
    setParameterDefault('nEnd',n);
    fd = fopen(filename);
    if(fd<0)
        error('%s not found. Please execute "translate" first to get the converted file',filename);
    end

    d = height*width;
    n=nEnd-nBeg+1;
    data=dlmread(filename);
    data=sparse(data(:,1),data(:,2),data(:,3),n,d+1);
    Y = full(data(nBeg:nEnd,1));
    X = data(nBeg:nEnd,2:end);
    fclose(fd);
end
