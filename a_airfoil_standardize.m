function [xq, yq] = a_airfoil_standardize(x, y, res)
    x1 = [];
    x2 = [];
    y1 = [];
    y2 = [];

    x_last = 2;
    for i = 1:length(x)
        if x(i) > x_last
            x1 = x(1:(i-1),1);
            x2 = [0; x((i+1):length(x))];
            y1 = y(1:(i-1),1);
            y2 = [0; y((i+1):length(x))];
            break
        end
        x_last = x(i);
    end

    xq1 = 1:-res:0;
    xq2 = res:res:1;

    yq1 = interp1(x1,y1,xq1);
    yq2 = interp1(x2,y2,xq2);

    xq = [xq1 xq2];
    yq = [yq1 yq2];
end