%% Data
l = [ 500 550 600 650 700 750 800 850 900 938 943 946 947 948 949 950 951 952 953 954 955 956 957 958 970 980];
Tf = [1924250 1924495 1926516 1929828 1932710 1936572 1940110 1944905 ...
    1950430 1954884 1955018 1955706 1955538 1955726 1955627 1956373 ...
    1956370 1955812 1956604 1956237 1956296 1956439 1955956 1956437 1957400 1960235];
Tr = [1986337 1906754 1862735 1846083 1844363 1854010 1871939 1895564 ... 
    1924104 1947522 1951071 1952400 1952573 1953447 1954420 1955235 1955881 ...
    1956093 1957295 1957617 1958237 1959252 1959535 1960032 1968252 1974522];

%% Gravity functions
grav = @(l,T)  l / (T/ (2 * pi))^2;
grav_true = @(beta) 9.78049*(1 + 0.0052884 * sin(beta)^2-0.0000059 * sin(2*beta)^2);

% Convert to SI units (should we do it here?)
l_m =  l.*10^-3;
Tf_s = Tf.*10^-6;
Tr_s = Tr.*10^-6;

%% Plot all
plot_lines(l_m, Tf_s, Tr_s);

%% Decide which data points to use
len = length(l);
first = 11;
last  = len-2;

%% Extract those data points
l_part = l_m(first:last);
Tf_part = Tf_s(first:last);
Tr_part = Tr_s(first:last);

%% Plot the linear regression 
[p_f, Y_f, delta_f]  = do_polyfit(l_part, Tf_part);
[p_r, Y_r, delta_r]  = do_polyfit(l_part, Tr_part);

%% Plot the confidence interval
make_plot(l_part, [Y_f; Y_r], [delta_f; delta_r])


%% Find where the lines cross
l_at_intersect = roots(p_f-p_r)
T_at_intersect = polyval(p_f, l_at_intersect)

%% Calculate Gravity
g_ours = grav(l_at_intersect, T_at_intersect)
g_true = grav_true(deg2rad(63.5))


%% measurement uncertainty
[xx, yy] = confidence_intersects(l_part, Y_f, Y_r, delta_f, delta_r);
g_at_conf_intersects = arrayfun(grav,xx, yy);
g_max = max(g_at_conf_intersects)
g_min = min(g_at_conf_intersects)

g_uncertainty = (g_max-g_min) / 2


%% Get polynomial, Y values,condifence interfcal
function [p,Y,delta] = do_polyfit(x,y) 
[p,S]     = polyfit(x,y,1);  % Polynomial fitting 1 degree
[Y,delta] = polyconf(p,x,S); % Evaluate (delta is 95% confidence)
end

%% Plot confidence, x, [Y1; Y2] [delta1;delta2]
function [] = make_plot(x, Y, delta)
    figure;
    hold on;
   
    plot(x,Y, 'o'); % Plot data point 
    plot(x,Y)  % Plot the line
    plot(x,Y+delta,'m--',x,Y-delta,'m--') % Plot confidence
    axis square
    ylabel("T (s)");
    xlabel("l (m)");
    legend(["Fast Egg", "Rörlig Egg",'Linjärisering Fast', "Linjärisering Rörlig", '95% Konfidens Intervall'] , 'location', 'southeast')
    print(gcf,'sampling-confidence','-dpng','-r600');
end
%% Get Intersection of confidence intervals
function [x_at_intersects, y_at_intersects] = confidence_intersects(x, Yf, Yr, deltaf, deltar)
    % Make polynomials from the confidence
    pf_top = polyfit(x,Yf + deltaf,1); 
    pf_bot = polyfit(x,Yf - deltaf,1); 
    pr_top = polyfit(x,Yr + deltar,1); 
    pr_bot = polyfit(x,Yr - deltar,1); 
    
    % Find x at intersects
    x1 = roots(pf_top - pr_top);
    x2 = roots(pf_top - pr_bot);
    x3 = roots(pf_bot - pr_top);
    x4 = roots(pf_bot - pr_bot);
    
    % Compute y at intersects
    y1 = polyval(pf_top, x1);
    y2 = polyval(pf_top, x1);
    y3 = polyval(pf_bot, x1);
    y4 = polyval(pf_bot, x1);
    
    x_at_intersects = [x1 x2 x3 x4];
    y_at_intersects = [y1 y2 y3 y4];
end

function plot_lines(l, Tf, Tr) 
    
    figure
    hold on
    plot(l, Tf, '-o')
    plot(l, Tr, '-o')
    axis square
    ylabel("T (s)");
    xlabel("l (m)");
    legend(["Fast Egg", "Rörlig Egg"], 'location', 'southeast');
    print(gcf,'all-data','-dpng','-r600');
    return;

end
