function [n Y X]=addPsudoInstance(Y,X,X0)
    global height width
    GLOBALVAR;
    d=height*width;
    [n Y X]=transform(X0,Y,X,d,@(x)imrotate(x,10,'crop'));
    [n Y X]=transform(X0,Y,X,d,@(x)imrotate(x,-10,'crop'));
end

function [n Y X]=transform(X0,Y,X,d,func)    
    n0=size(X0,1);
    n=size(Y,1)+n0;
    Y=[Y;Y(1:n0)];
    for i=1:n0
        X=[X;reshape(func(X0{i,1}),1,d)];
    end
end