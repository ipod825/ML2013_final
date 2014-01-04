function [n Y X]=addPsudoInstance(Y,X,X0,num)
    global height width
    GLOBALVAR;
    d=height*width;
    n0=size(X0,1);
%     num=floor(num/2);
    [Y X]=transform(X0,Y,X, num,d,@(x)affine(x,height,width));
%     [Y X]=transform(X0,Y,X, num,d,@(x)imrotate(x,15*(rand(1)-0.5),'crop'));
    n=size(Y,1);
end

function [Y X]=transform(X0,Y,X,num,d,func)
    h=waitbar(0,'Transforming');
    inds=randsample(size(X0,1),num);
    Y=[Y;Y(inds)];
    X=[X;zeros(num,d)];
    beg=size(X,1)+1;
    for i=1:num
        waitbar(i/num);
        X(beg+i,:)=reshape(func(X0{inds(i)}),1,d);
    end
    close(h);
end

function ret=affine(img,height,width)
    if rand(1)>0.5
        T = [1  (rand(1)-0.5)/2;
            0  1;
            0  0];
    else
        T = [1  0;
            (rand(1)-0.5)/2  1;
            0  0];
    end
    tf = maketform('affine',T);
    ret = imresize(imtransform(img,tf,'FillValues',0), [width, height]);
end