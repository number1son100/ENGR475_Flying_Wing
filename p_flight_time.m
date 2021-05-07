function [t_flight, P] = p_flight_time(prop_number, v, T)      % Finds flight time in minutes, given a prop number, arspeed, and thrust
    mAh = 190;
    V = 7.4;
    Wh = mAh*V/1000;
    Ws = Wh*60^2;
    [P, T_max] = p_prop_info(prop_number, v, T);
    if T > T_max
        t_flight = 0;
        %fprintf("Thrust cannot reach that value.\n");
        return;
    end
    t_flight = Ws/P/60;
end