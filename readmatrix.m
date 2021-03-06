function [Y,X] = readmatrix(filename, n, height, width)
% READMATRIX read all data from the normalized image file
% [Y,X] = readmatrix(filename)
%   Output:
%   Y: labels array
%   X: image sparse matrix
    fd = fopen(filename);
    if(fd<0)
        error('%s not found. Please execute "preprocessing" or "translate" first to get the normalized image file',filename);
    end

    d = height*width;
    data=dlmread(filename);
    data=sparse(data(:,1),data(:,2),data(:,3),n,d+1);
    Y = full(data(:,1));
    X = data(:,2:end);
    Y=Y(1:n);
    X=X(1:n,:);
    fclose(fd);
end
