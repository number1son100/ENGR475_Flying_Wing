function [yd] = a_airfoil_interpolate_standardized(b, d, x, yr, yt)
    yd = 2*d/b*(yt-yr)+yr;
end