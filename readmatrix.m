function [Y,X, height, width] = readmatrix(filename)
% READFILE read from training data
% [Y,X, height, width] = readfile(filename)
%   Output:
%   Y: labels array
%   X: image sparse matrix
%   height: height of image
%   width: width of image

if nargin<1 || isempty(filename)
    filename = './ml2013final_train.dat';
end

height = 122;
width = 105;
d = height*width;
n = 10;

Y = zeros(n,1);
X = sparse(n,d);

fd = fopen(filename);

for i = 1:n
	line = fgetl(fd);
	splitline = strread(line, '%s');
	Y(i) = str2double(splitline{1});
	for j = 2:length(splitline)
		data = sscanf(splitline{j}, '%f:%f');
		X(i,(data(1))) = data(2);
	end
end

fclose(fd);

end
