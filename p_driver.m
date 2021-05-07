warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');

v = 0:0.5:7.5;
T = v./v/3.596943079091022;

figure(1)
p_throttle_graph(2, v, T)
title('Propeller 2 Thrust vs Airspeed');

figure(2);
p_excess_thrust_graph(v, T);
title('Excess Thrust vs Airspeed for All Propellers');

figure(3);
p_power_graph(v, T);
title('Power vs Airspeed for All Propellers');

p_flight_time(1, 6, 1.5);

for v = 0:5:10
    for T = (0.5:1.0:2.5)/3.596943079091022
        fprintf("Airspeed: %d, Thrust: %f, Best Prop: %d\n", v, T, p_best_propeller(v, T));
    end
end