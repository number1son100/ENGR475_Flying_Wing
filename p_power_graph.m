function [] = p_power_graph(v, T)
    [P_1, ~] = p_prop_info(1, v, T);
    [P_2, ~] = p_prop_info(2, v, T);
    [P_3, ~] = p_prop_info(3, v, T);
    [P_4, ~] = p_prop_info(4, v, T);
    
    hold on;
    plot(v, P_1);
    plot(v, P_2);
    plot(v, P_3);
    plot(v, P_4);
    hold off
    
    grid on;
    xlabel('Airspeed (m/s)');      % Correct axis labeling always includes the
    ylabel('Power Supplied (W)');   % variables being plotted *and* their units!
    legend("Propeller 1", "Propeller 2", "Propeller 3", "Propeller 4", "Location", "southwest");
end