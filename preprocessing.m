function preprocessing(trainOrTest)
%PREPROCESSING translate raw data to feature data.
%PREPROCESSING(true) translate for training file, while PREPROCESSING(false) for testing file.
%The new format is a sparse matrix in the form of [Y X], where Y is the label and X is the raw image pixel grayscale value.
%For more information, please check readmatrix.m.
    global height width normSideLength isTraining dataFname normimgFName n
    isTraining=trainOrTest;
    GLOBALVAR;
    
    [Y,X]=readmatrix(dataFname,n,height,width);
    d=normSideLength*normSideLength;
    Xnorm=zeros(n,d);
    h = waitbar(0,'Normalization...');
    for i=1:n
        Xnorm(i,:)=reshape(normalizeImg(X(i,:)),1,d);
        waitbar(i / n);
    end
    close(h);
    [i, j, k]=find(sparse([Y Xnorm]));
    dlmwrite(normimgFName,[i j k]);
end