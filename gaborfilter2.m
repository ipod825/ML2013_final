%%%%%%%VERSION 3
%%ANOTHER DESCRIBTION OF GABOR FILTER

%The Gabor filter is basically a Gaussian (with variances sx and sy along x and y-axes respectively)
%modulated by a complex sinusoid (with centre frequencies U and V along x and y-axes respectively) 
%described by the following equation
%%
%                   -1     x  ^    y  ^
%%% Gi(x,y) = exp ([----{(----) 2+(----) 2}])*Mi(x,y,f); 
%                    2    sx       sy

function gb = gaborfilter2(Sx,Sy,f,theta);
nstds = 1;
psi=0;
rmax = max(nstds*abs(Sx*cos(theta)),abs(nstds*Sy*sin(theta)));
rmax = ceil(max(1,rmax));
cmax = max(abs(nstds*Sx*sin(theta)),abs(nstds*Sy*cos(theta)));
cmax = ceil(max(1,cmax));
rmin = -rmax; cmin = -cmax;
[x,y] = meshgrid(rmin:rmax,cmin:cmax);

xtheta=x*cos(theta)+y*sin(theta);
ytheta=-x*sin(theta)+y*cos(theta);
% gb2= exp(-.5*(xtheta.^2/Sx^2+ytheta.^2/Sy^2)).*cos(2*pi*f*xtheta+psi);
% (xtheta.^2/Sx^2+ytheta.^2/Sy^2) is equal to (x.^2/Sx^2+y.^2/Sy^2) since
% the former is just a rotation
gb= exp(-.5*(x.^2/Sx^2+y.^2/Sy^2)).*cos(2*pi*f*xtheta+psi);