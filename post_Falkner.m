% Falkner_Skan_Flow ÇÃÉvÉçÉbÉg

clear all
close all
clc

load Falkner_Skan_Flow.mat

figure
plot(H,M);
xlabel('Shape Factor H');
ylabel('Dimensionless Pressure Gradient m');
savefig('figures/H vs. m.fig');

figure
plot(H,S);
xlabel('Shape Factor H');
ylabel('Velocity Gradient on the wall s');
savefig('figures/H vs. s.fig');

m = M(1:100:end);
[~]=SetColorMap(hsv,length(m));

figure
plot(DF(1:100:end,:),ETA);
str = compose('m=%4.3f',m);
legend(str);
xlabel('Velocity U');
ylabel('\eta');
savefig('figures/U vs. eta.fig');
