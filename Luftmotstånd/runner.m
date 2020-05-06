% Frekvens (rot/s)
f = [8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38];

% Golfboll
Lg = [0.304 0.306 0.307 0.307 0.308 0.309 0.315 0.339 0.341 0.343 0.340 0.344 0.342 0.338 0.336 0.337].';  %m
mg = 4.5E-3; 
dg = 42E-3;
rg = dg/2;
Ag = pi * rg^2;
Rg = Lg - rg;
% Pingisboll 
Lp = [0.249 0.247 0.247 0.247 0.246 0.246 0.246 0.246 0.246 0.246 0.246 0.246 0.246 0.246 0.245 0.244].'; %m
mp = 2.5E-3; 
dp = 38E-3;
rp = dp/2;
Ap = pi * rp^2;
Rp = Lp - rp;
% Measurments
n = length(f);

% Radius of axel
a = 1E-2; 




eta_air = 1.86E-5;
rho_air = 1.21;

Re     = @(rho,v,d,eta) (rho*v*d)/eta;
stokes = @(eta,r,v) 6*pi*eta*r*v;        %Drag laminar
turbul = @(rho,v,Cd,A) (1/2)* rho*v^2*A; %Drag turbulent

Cd = @(m,a,rho,A,R) (2*m*a) / ((rho *A*R* sqrt(R^2 - a^2)));

%Ball velocity
vg = frequency_to_velocity(f, Rg);
vp = frequency_to_velocity(f, Rp);  


Re_g = Re(rho_air, vg, dg, eta_air);
Re_p = Re(rho_air, vp, dp, eta_air);



stokesg = stokes(eta_air, rg,vg);
stokesp = stokes(eta_air, rp,vp);

Cdg = zeros(n,1);
Cdp = zeros(n,1);
for i = 1:n 
   Cdg(i) = Cd(mg, a, rho_air, Ag, Rg(i));
   Cdp(i) = Cd(mp, a, rho_air, Ap, Rp(i));
end




%plot_cd_against_v(vg, Cdg, vp, Cdp);
%plot_cd_against_re(Re_g, Cdg, Re_p, Cdp);
%plot_cd_against_re_log(Re_g, Cdg, Re_p, Cdp);
%plot_stokes_against_v(vg,stokesg, vp, stokesp) 

Mrg = 45.73E-3;
Arg = ((42.69E-3)/2)^2 * pi ;

F = Mrg * 9.82;
Cd2 = 0.51


v = sqrt((F *2) / (Cd2 * Arg* rho_air))

function plot_cd_against_v(vg, Cdg, vp, Cdp)
        
figure;
hold on;
grid on;
xlabel ("v (m/s)");
ylabel ("Cd");

plot(vg, Cdg);
plot(vp, Cdp);
end
function plot_cd_against_re(Re_g, Cdg,Re_p, Cdp) 
figure;
hold on;
grid on;
xlabel ("Re");
ylabel ("Cd");

plot(Re_g, Cdg);
plot(Re_p, Cdp);
end
function plot_cd_against_re_log(Re_g, Cdg,Re_p, Cdp) 
    figure;
    hold on;
    grid on;
    plot(log(Re_g), Cdg);
    plot(log(Re_p), Cdp);
    xlabel ("log(Re)");
    ylabel ("Cd");
end
function plot_stokes_against_v(vg,stokesg, vp, stokesp) 

    figure;
    hold on;
    grid on;
    plot(vg, stokesg);
    plot(vp, stokesp);
 
    xlabel ("v(m/s)");
    ylabel ("asdasd");
    legend("Golfboll", "Pingisboll")
end
function [v] = frequency_to_velocity(f, r)
    n = length(f);
    v=zeros(n,1);
    for i =1:n
        v(i) = 2*pi*f(i) * r(i);
    end
end

