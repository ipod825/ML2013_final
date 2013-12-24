function [Y,X, height, width] = readmatrix(filename, nBeg, nEnd)
% READFILE read from training data
% [Y,X, height, width] = readfile(filename)
%   Output:
%   Y: labels array
%   X: image sparse matrix
%   height: height of image
%   width: width of image
setParameterDefault('filename','./ml2013final_train.dat');
setParameterDefault('nBeg',1);
setParameterDefault('nEnd',6144);
    
height = 122;
width = 105;
d = height*width;
nMax=6144;
n=nEnd-nBeg;
Y = zeros(n,1);
X = sparse(n,d);

fd = fopen(filename);

for i = 1:nMax
    line = fgetl(fd);
    if i<nBeg continue; end
    if i>nEnd break; end
    ind=i-nBeg+1;
	splitline = strread(line, '%s');
	Y(ind) = str2double(splitline{1});
	for j = 2:length(splitline)
		data = sscanf(splitline{j}, '%f:%f');
		X(ind,(data(1))) = data(2);
	end
end

fclose(fd);

end