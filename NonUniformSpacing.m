function [y] = NonUniformSpacing(jn,YL,yTH)
y0=linspace(-1,1,jn);
a=yTH*YL./(YL-2*yTH);
b=1+2*a./YL;
y = a*(1+y0)./(b-y0);
end