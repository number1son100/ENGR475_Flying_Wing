function [] = throttle_graph(prop_number, v, T)
    data = readtable('throttle.xlsx');

    prop_data = data(24*(prop_number-1)+1:24*(prop_number), 2:4);

    hold on
    plot(v, T);
    for i = 1:6
        plot(prop_data{(i-1)*4+1:(i-1)*4+4,2}/196.85039370078738, prop_data{(i-1)*4+1:(i-1)*4+4,3}/3.596943079091022);
    end
    hold off

    grid on;
    xlabel('Airspeed (m/s)');      % Correct axis labeling always includes the
    ylabel('Thrust (N)');   % variables being plotted *and* their units!
    legend("Airfoil Drag Data" , "-0.5 Throttle", "0.0 Throttle", "0.5 Throttle", "1.0 Throttle", "1.5 Throttle", "2.0 Throttle", "Location", "southwest");
end