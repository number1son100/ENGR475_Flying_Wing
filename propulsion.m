function [t, P, n] = propulsion(v, T)
    [n, t, P] = p_best_propeller(v, T);
    %fprintf("Drag: %d, Power: %d, Flight Time: %d\n", T, P, t);
end