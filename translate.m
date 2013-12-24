%Thie function translate the original data format to a file with format
%which is more easy to parse.
%The new format is a sparse matrix in tthe form of [Y X], where Y is the
%label and X is the raw image pixel grayscale value.
%For more information, please check readmatrix.m.
global height width n
GLOBALVAR;

d = height*width;

fd = fopen('./ml2013final_train.dat');
ofd = fopen('mltrain_sparse.dat','w');

for i = 1:n
    line = fgetl(fd);
    if(line==-1)
        break;
    end
    ind=i;
	splitline = strread(line, '%s');
    data_dump=[ind, 1, str2double(splitline{1})];
    fprintf( ofd,'%d %d %d\n', data_dump);    
	for j = 2:length(splitline)
		data = sscanf(splitline{j}, '%f:%f');
        data_dump=[ind, (data(1)+1), data(2)];
        fprintf( ofd,'%d %d %f\n', data_dump);
	end
end

fclose(fd);
fclose(ofd);