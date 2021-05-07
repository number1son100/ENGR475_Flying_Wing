v = 1:0.08:8;
T = 1:length(v);
for i = T
    T(i) = aerodynamics(S, AR, t, Sh, ARh, th, Sv, ARv, tv, V, W);

% Get four graphs of Drag vs Airspeed, with throttle settings. The four
% graphs are for the four propellers.
figure(3)
plot(v, T);
p_throttle_graph(1, v, T)
title('Propeller 1 Thrust vs Airspeed');
ylim([0 1])

figure(4)
plot(v, T);
p_throttle_graph(2, v, T)
title('Propeller 2 Thrust vs Airspeed');
ylim([0 1])

figure(5)
plot(v, T);
p_throttle_graph(3, v, T)
title('Propeller 3 Thrust vs Airspeed');
ylim([0 1])

figure(6)
plot(v, T);
p_throttle_graph(4, v, T)
title('Propeller 4 Thrust vs Airspeed');
ylim([0 1])

% Get a graph for power required as a function of airspeed for all four
% propellers
figure(7)
hold on;
p_power_graph(v, T);
title('Power vs Airspeed for All Propellers');

% Get a graph for percent excess thrust versus airspeed for all four
% propellers
figure(8)
hold on;
p_excess_thrust_graph(v, T);
title('Excess Thrust vs Airspeed for All Propellers');