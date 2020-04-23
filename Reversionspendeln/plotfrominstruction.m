m = 0; % min
M = 5; % max
x = linspace(m,M);
r = x;

figure 
hold on

ylim([m M])
xlim([m M])
plot(x,r)
plot(x,1./r);
plot(x,r+1./r);