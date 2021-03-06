function [Y,X] = guireadmatrix(filename, nBeg, nEnd, only)
% GUIREADMATRIX read partial data from the training file
% [Y,X] = guireadmatrix(filename)
%   Output:
%   Y: labels array
%   X: image sparse matrix

global height width n 
GLOBALVAR;

setParameterDefault('nBeg',1);
setParameterDefault('nEnd',n);
setParameterDefault('only',-1);
    
d = height*width;
nMax=n;
N=nEnd-nBeg+1;
Y = zeros(N,1);
X = sparse(N,d);

fd = fopen(filename);

h = waitbar(0,'Reading data...');
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
    waitbar(i / n);
end
close(h);

if(only>0)
    inds=find(Y==only);
    Y=Y(inds);
    X=X(inds,:);
end

fclose(fd);

end