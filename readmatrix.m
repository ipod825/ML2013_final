function [Y,X] = readmatrix(filename, n, height, width)
% READMATRIX read all data from the training file
% [Y,X] = readmatrix(filename)
%   Output:
%   Y: labels array
%   X: image sparse matrix
    fd = fopen(filename);
    if(fd<0)
        error('%s not found. Please execute "translate" first to get the converted file',filename);
    end

    d = height*width;
    data=dlmread(filename);
    data=sparse(data(:,1),data(:,2),data(:,3),n,d+1);
    Y = full(data(:,1));
    X = data(:,2:end);
    fclose(fd);
end
