global height width normSideLength isTraining dataFname normimgFName n
    isTraining=true;
    GLOBALVAR;
    

%     [Y,X]=readmatrix(dataFname,n,height,width);    
%     X0=cell(n,1);
%     for i=1:n
%         X0{i,1}=full(reshape(X(i,:),width,height));
%     end
    [nn Y X]=addPsudoInstance(Y,X,X0,6000);
    d=normSideLength*normSideLength;
    Xnorm=zeros(nn,d);
    h = waitbar(0,'Normalization...');
    for i=1:nn
        Xnorm(i,:)=reshape(normalizeImg(X(i,:)),1,d);
        waitbar(i / nn);
    end
    close(h);
    [i, j, k]=find(sparse([Y Xnorm]));
    dlmwrite(normimgFName,[i j k]);