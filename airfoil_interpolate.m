function [x, yd] = airfoil_interpolate(b, d, xr, yr, xt, yt, res, filename)
    [x, yt] = a_airfoil_standardize(xt, yt, res);
    [~, yr] = a_airfoil_standardize(xr, yr, res);

    [yd] = a_airfoil_interpolate_standardized(b, d, x, yr, yt);
    
    for i = 1:length(yd)
        if isnan(yd(i))
            yd(i) = 0;
        end
    end
    
    data = [x; yd];

    writematrix(data',filename, 'Delimiter', '\t')
end