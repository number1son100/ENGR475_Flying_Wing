function [] = excess_thrust_graph(v, T)
    [~, T_max] = p_prop_info(1, v, T);
    prop_1_excess = (T_max-T)./(T)*100;
    [~, T_max] = p_prop_info(2, v, T);
    prop_2_excess = (T_max-T)./(T)*100;
    [~, T_max] = p_prop_info(3, v, T);
    prop_3_excess = (T_max-T)./(T)*100;
    [~, T_max] = p_prop_info(4, v, T);
    prop_4_excess = (T_max-T)./(T)*100;
    
    
    hold on;
    plot(v, prop_1_excess);
    plot(v, prop_2_excess);
    plot(v, prop_3_excess);
    plot(v, prop_4_excess);
    hold off
    
    grid on;
    xlabel('Airspeed (m/s)');      % Correct axis labeling always includes the
    ylabel('Percent Excess Thrust (%)');   % variables being plotted *and* their units!
    legend("Propeller 1", "Propeller 2", "Propeller 3", "Propeller 4", "Location", "southwest");

end