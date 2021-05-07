function [n, flight_time, Power] = p_best_propeller(v, T)
    t_flight = [0 0 0 0];
    P = [0 0 0 0];
    [t_flight(1), P(1)] = p_flight_time(1, v, T);
    [t_flight(2), P(2)] = p_flight_time(2, v, T);
    [t_flight(3), P(3)] = p_flight_time(3, v, T);
    [t_flight(4), P(4)] = p_flight_time(4, v, T);
    
    flight_time = 0;
    Power = 0;
    n = 0;
    for i = 1:4
        if t_flight(i) > flight_time
            t_max = t_flight(i);
            n = i;
            flight_time = t_max;
            Power = P(n);
        end
    end
    if n==0
        fprintf("No propeller will allow flight at this airspeed and thrust.\n");
    end
end