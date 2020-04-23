go = 9.8177;
gt = 9.8219;
gu = 0.0191;


figure 
hold on
set(gca,'xtick',[]) % Hide x axis
ylabel("m/s^2");

h = plot([go], 'o');
h = plot([gt], 'o');
er = errorbar(go,gu, 'k');
legend("Computed Gravity", "Actual Gravity", "Measurement uncertainty");