function [ ylist,xlist ] = readfile(filename)

if isempty(filename)
	filename = '../testdata/ml2013final_train.dat';
end

width = 105;
height = 122;
d = width*height;
n = 2;

ylist = zeros(n,1);
xlist = sparse(n,d);

fd = fopen(filename);

for i = 1:n
	line = fgetl(fd);
	splitline = strread(line, '%s');
	ylist(i) = str2double(splitline{1});
	for j = 2:length(splitline)
		data = sscanf(splitline{j}, '%f:%f');
		xlist(i,data(1)) = data(2);
	end
end

fclose(fd);

end
