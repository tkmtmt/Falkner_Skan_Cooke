clear all
close all
clc

jn = 100;
YL = 7;
yTH = 5;
eta = NonUniformSpacing(jn,YL,yTH);

m = 0.0;
beta = 2*m/(m+1);
gamma = deg2rad(10);
s0 = 0.5;
[~,f,df,ddf,~,~,~,~] = FS_Pos(eta,s0,m);
g = 1-exp(-f(:).*eta(:));

Ue = df*cos(gamma)^2+g*sin(gamma)^2;
We = cos(gamma)*sin(gamma)*(g-df);

plot(eta,Ue,eta,We)