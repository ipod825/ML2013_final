height = 122;
width = 105;
d = height*width;
nMax=6144;

fd = fopen('./ml2013final_train.dat');
ofd = fopen('mltrain_sparse.dat','w');

for i = 1:nMax
    line = fgetl(fd);
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