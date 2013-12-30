function Eval=crossvalidation(Y,X,fold,cls)
	leaveNum=floor(n/fold);
    % inds = uniformArray(n,1,n);
    inds=1:n;
    groups=zeros(n,1);
    group=0;
    for i=1:n
        if mod(i,leaveNum)==1 && group<fold
            group=group+1;
        end
        groups(inds(i))=group;
    end

    Eval=0;
    for i=1:fold
        trainInds=find(groups~=i);
        testInds=find(groups==i);
        clear cls;
        cls.train(Y(trainInds,1),X(trainInds,:));
        pred=cls.classify(X(testInds,:));
        Eval=Eval+(size(find(Y~=pred))/size(testInds,1));
    end
    Eval=Eval/fold;
end