function translate(trainOrTest)
%TRANSLATE translate data file format.
%TRANSLATE(true) translate for training file, while TRANSLATE(false) for testing file.
%The new format is a sparse matrix in the form of [Y X], where Y is the label and X is the raw image pixel grayscale value.
%For more information, please check readmatrix.m.
    
    global height width isTraining dataFname n rawdataFName
    isTraining=trainOrTest;
    GLOBALVAR;

    d = height*width;
    fd = fopen(rawdataFName);
    ofd = fopen(dataFname,'w');
    if(fd<0)
        error('You miss %s, please move it to the current directory.',rawdataFName);
    end
    h = waitbar(0,'Translating...');
    for i = 1:n    
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
        waitbar(i / n);
    end
    close(h);
    fclose(fd);
    fclose(ofd);
end