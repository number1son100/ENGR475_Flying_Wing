MH45 = readmatrix('MH 60.txt');
HS522 = readmatrix('HS 522.txt');

b = 40;
d = 9.54;
res = 0.02;
filename = 'Intermediate.txt';

xt = MH45(:,1);
yt = MH45(:,2);

xr = HS522(:,1);
yr = HS522(:,2);

hold on;
plot(xt, yt);
plot(xr, yr);

[x, yd] = airfoil_interpolate(b, d, xr, yr, xt, yt, res, filename);
plot(x, yd);

xlim([0 1])
ylim([-0.5 0.5])

hold off;
legend('Tip', 'Root', 'Intermediate');