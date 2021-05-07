%% Gather Data
close all
clear variables
clc

warning('off','MATLAB:table:ModifiedAndSavedVarnames');
% 
% % Design variable choices
% V = 15;      % flight velocity (ft/s)
% b = 40;      % wing span (inches)
% cavg = 10;  % average wing chord length (inches)
sweep_quarter = 25.8;
t = 0.42; % wing taper ratio

V = 3:0.1:4;
b = 30:4:50;
c = 4:2:10;

% V = [1];
% b = [50];
% c = [4];

Vlen = length(V);
blen = length(b);
clen = length(c);

P = zeros(Vlen, blen, clen);
W = zeros(Vlen, blen, clen);
CG = zeros(Vlen, blen, clen);
D = zeros(Vlen, blen, clen);
CDp = zeros(Vlen, blen, clen);
CDi = zeros(Vlen, blen, clen);
alpha = zeros(Vlen, blen, clen);
Cl = zeros(Vlen, blen, clen);
SM = zeros(Vlen, blen, clen);
Btwist = zeros(Vlen, blen, clen);
time = zeros(Vlen, blen, clen);
n = zeros(Vlen, blen, clen);
for i = 1:blen
    for j = 1:clen
        for k = 1:Vlen
            [P(k, i, j), W(k, i, j), CG(k, i, j), D(k, i, j), CDp(k, i, j), CDi(k, i, j), alpha(k, i, j), Cl(k, i, j), SM(k, i, j), Btwist(k, i, j), time(k, i, j), n(k, i, j)] = main(V(k), b(i), c(j), t, sweep_quarter);
        end
    end
end
save('attempt')
%% Output Optimal Values
load('attempt')
k = 1;
i = 1;
j = 1;
for i = 1:blen
    for j = 1:clen
        best = [V(k), c(j), b(i), P(k, i, j), W(k, i, j), CG(k, i, j), D(k, i, j), CDp(k, i, j), CDi(k, i, j), alpha(k, i, j), Cl(k, i, j), SM(k, i, j), Btwist(k, i, j), time(k, i, j), n(k, i, j)];
        for k = 1:Vlen
            if P(k, i, j) < best(4)
                best = [V(k), c(j), b(i), P(k, i, j), W(k, i, j), CG(k, i, j), D(k, i, j), CDp(k, i, j), CDi(k, i, j), alpha(k, i, j), Cl(k, i, j), SM(k, i, j), Btwist(k, i, j), time(k, i, j), n(k, i, j)];
            end
        end
        table({'V', 'c', 'b', 'P', 'W', 'CG', 'D/T', 'CDp', 'CDi', 'alpha', 'Cl', 'SM', 'Btwist', 'time', 'prop'}', best')
    end
end


%% Optimize Completely
load('attempt')
k = 1;
i = 1;
j = 1;
best = [V(k), c(j), b(i), P(k, i, j), W(k, i, j), CG(k, i, j), D(k, i, j), CDp(k, i, j), CDi(k, i, j), alpha(k, i, j), Cl(k, i, j), SM(k, i, j), Btwist(k, i, j), time(k, i, j), n(k, i, j)];
for i = 1:blen
    for j = 1:clen
        for k = 1:Vlen
            if P(k, i, j) < best(4)
                best = [V(k), c(j), b(i), P(k, i, j), W(k, i, j), CG(k, i, j), D(k, i, j), CDp(k, i, j), CDi(k, i, j), alpha(k, i, j), Cl(k, i, j), SM(k, i, j), Btwist(k, i, j), time(k, i, j), n(k, i, j)];
            end
        end
    end
end

fprintf("The optimal configuration is b=%d in and c=%d in with propeller %d at an airspeed of v=%d m/s, taking P=%d W of power.", [best(3), best(2), best(15), best(1), best(4)]);
fprintf("This yields a flight time of %d minutes. The static margin is %d\n", [best(14), best(12)]);
fprintf("This gives a weight estimate of %d N, a center of gravity at %d m from the leading edge of the plane, and a wing twist of %d degrees.\n", [best(5), best(6), best(13)]);
%% Plot
load('attempt')

% % Velocity Graphs
o1 = 1;
o2 = 2;
% plot_properties(P , 'Power', 'W', V, b, c, o1, o2);
 plot_properties(W , 'Weight', 'N', V, b, c, o1, o2);
% plot_properties(CG , 'Center of Gravity', 'm', V, b, c, o1, o2);
% plot_properties(D , 'Drag/Thrust', 'N', V, b, c, o1, o2);
% plot_properties(CDp+CDi , 'Coefficient of Parasitic Drag', 'Unitless', V, b, c, o1, o2);
% plot_properties(CDi , 'Coefficient of Induced Drag', 'Unitless', V, b, c, o1, o2);
% plot_properties(alpha , 'Angle of Attack', 'Degrees', V, b, c, o1, o2);
% plot_properties(Cl , 'Coefficient of Lift', 'Unitless', V, b, c, o1, o2);
% plot_properties(SM , 'Stability Margin', 'Unitless', V, b, c, o1, o2);
% plot_properties(Btwist , 'Wing Twist', 'Degrees', V, b, c, o1, o2);
% plot_properties(time , 'Flight Time', 's', V, b, c, o1, o2);
% plot_properties(n , 'Propeller', 'Unitless', V, b, c, o1, o2);
% 
% % Wingspan Graphs
o1 = 2;
o2 = 2;
% plot_properties(P , 'Power', 'W', V, b, c, o1, o2);
% plot_properties(W , 'Weight', 'N', V, b, c, o1, o2);
% plot_properties(CG , 'Center of Gravity', 'm', V, b, c, o1, o2);
% plot_properties(D , 'Drag/Thrust', 'N', V, b, c, o1, o2);
% plot_properties(CDp , 'Coefficient of Parasitic Drag', 'Unitless', V, b, c, o1, o2);
% plot_properties(CDi , 'Coefficient of Induced Drag', 'Unitless', V, b, c, o1, o2);
% plot_properties(alpha , 'Angle of Attack', 'Degrees', V, b, c, o1, o2);
% plot_properties(Cl , 'Coefficient of Lift', 'Unitless', V, b, c, o1, o2);
% plot_properties(SM , 'Stability Margin', 'Unitless', V, b, c, o1, o2);
% plot_properties(Btwist , 'Wing Twist', 'Degrees', V, b, c, o1, o2);
% plot_properties(time , 'Flight Time', 's', V, b, c, o1, o2);
% plot_properties(n , 'Propeller', 'Unitless', V, b, c, o1, o2);

% Chord Graphs
o1 = 3;
o2 = 3;
% plot_properties(P , 'Power', 'W', V, b, c, o1, o2);
% plot_properties(W , 'Weight', 'N', V, b, c, o1, o2);
% plot_properties(CG , 'Center of Gravity', 'm', V, b, c, o1, o2);
% plot_properties(D , 'Drag/Thrust', 'N', V, b, c, o1, o2);
% plot_properties(CDp , 'Coefficient of Parasitic Drag', 'Unitless', V, b, c, o1, o2);
% plot_properties(CDi , 'Coefficient of Induced Drag', 'Unitless', V, b, c, o1, o2);
% plot_properties(alpha , 'Angle of Attack', 'Degrees', V, b, c, o1, o2);
% plot_properties(Cl , 'Coefficient of Lift', 'Unitless', V, b, c, o1, o2);
% plot_properties(SM , 'Stability Margin', 'Unitless', V, b, c, o1, o2);
% plot_properties(Btwist , 'Wing Twist', 'Degrees', V, b, c, o1, o2);
% plot_properties(time , 'Flight Time', 's', V, b, c, o1, o2);
% plot_properties(n , 'Propeller', 'Unitless', V, b, c, o1, o2);


% options 1:
%   1 - Function of V
%   2 - Function of b
%   3 - Function of c
% options 2:
%   1 - All three
%   2 - All but the complete one
%   3 - Only the complete one
function [] = plot_properties(property, property_name, unit, V, b, c, options_1, options_2)

    Vlen = length(V);
    blen = length(b);
    clen = length(c);

    if options_1 == 1
        if options_2 == 1 || options_2 == 2
            for j = 1:clen
                leg = {};
                figure()
                hold on;
                grid on;
                for i = 1:blen
                    plot(V, property(:, i, j));
                    leg{end+1} = sprintf('b = %d', b(i));
                end
                title(sprintf("%s vs Airspeed for chord lengths of %d.",property_name, c(j)));
                xlabel('Airspeed (m/s)');      % Correct axis labeling always includes the
                ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
                legend(leg);
            end
            for i = 1:blen
                leg = {};
                figure()
                hold on;
                grid on;
                for j = 1:clen
                    plot(V, property(:, i, j));
                    leg{end+1} = sprintf('c = %d', c(j));
                end
                title(sprintf("%s vs Airspeed for wingspans of %d.", property_name,b(i)));
                xlabel('Airspeed (m/s)');      % Correct axis labeling always includes the
                ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
                legend(leg);
            end
        end

        if options_2 == 1 || options_2 == 3
            leg = {};
            figure()
            hold on;
            grid on;
            for i = 1:blen
                for j = 1:clen
                    plot(V, property(:, i, j));
                    leg{end+1} = sprintf('b = %d, c = %d', b(i), c(j));
                end
            end

            title(sprintf('%s vs Airspeed for All Configurations', property_name));
            xlabel('Airspeed (m/s)');      % Correct axis labeling always includes the
            ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
            legend(leg)
            %fprintf("The optimal configuration is b=%d in and c=%d in with propeller %d at an airspeed of v=%d m/s, taking P=%d W of power.\nThis yields a flight time of %d minutes.\nThis gives a weight estimate of %d N, a center of gravity at %d m from the leading edge of the plane, and a wing twist of %d degrees. The static margin is %d", best);
        end
    elseif options_1 == 2
        if options_2 == 1 || options_2 == 2
            for k = 1:Vlen
                leg = {};
                figure()
                hold on;
                grid on;
                for j = 1:clen
                    plot(b, permute(property(k, :, j), [2 3 1]));
                    leg{end+1} = sprintf('c = %d', c(j));
                end
                title(sprintf("%s vs Wingspan for velocities of %d.",property_name, V(k)));
                xlabel('Wingspan (in)');      % Correct axis labeling always includes the
                ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
                legend(leg);
            end
            for j = 1:clen
                leg = {};
                figure()
                hold on;
                grid on;
                for k = 1:Vlen
                    plot(b, permute(property(k, :, j), [2 3 1]));
                    leg{end+1} = sprintf('V = %d', V(k));
                end
                title(sprintf("%s vs Wingspan for chord lengths of %d.", property_name, c(j)));
                xlabel('Wingspan (in)');      % Correct axis labeling always includes the
                ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
                legend(leg);
            end
        end

        if options_2 == 1 || options_2 == 3
            leg = {};
            figure()
            hold on;
            grid on;
            for k = 1:Vlen
                for j = 1:clen
                    plot(b, permute(property(k, :, j), [2 3 1]));
                    leg{end+1} = sprintf('c = %d, V = %d', c(j), V(k));
                end
            end

            title(sprintf('%s vs Wingspan for All Configurations', property_name));
            xlabel('Wingspan (in)');      % Correct axis labeling always includes the
            ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
            legend(leg);            
            %fprintf("The optimal configuration is b=%d in and c=%d in with propeller %d at an airspeed of v=%d m/s, taking P=%d W of power.\nThis yields a flight time of %d minutes.\nThis gives a weight estimate of %d N, a center of gravity at %d m from the leading edge of the plane, and a wing twist of %d degrees. The static margin is %d", best);
        end
    else
        if options_2 == 1 || options_2 == 2
            for k = 1:Vlen
                leg = {};
                figure()
                hold on;
                grid on;
                for i = 1:blen
                    plot(c, permute(property(k, i, :), [3 2 1]));
                    leg{end+1} = sprintf('b = %d', b(i));
                end
                title(sprintf("%s vs Average Chord for velocities of %d.",property_name, V(k)));
                xlabel('Average Chord (in)');      % Correct axis labeling always includes the
                ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
                legend(leg);
            end
            for i = 1:blen
                leg = {};
                figure()
                hold on;
                grid on;
                for k = 1:Vlen
                    plot(c, permute(property(k, i, :), [3 2 1]));
                    leg{end+1} = sprintf('V = %d', V(k));
                end
                title(sprintf("%s vs Average Chord for wingspans of %d.", property_name, b(i)));
                xlabel('Average Chord (in)');      % Correct axis labeling always includes the
                ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
                legend(leg);
            end
        end

        if options_2 == 1 || options_2 == 3
            leg = {};
            figure()
            hold on;
            grid on;
            for k = 1:Vlen
                for i = 1:blen
                    plot(c, permute(property(k, i, :), [3 2 1]));
                    leg{end+1} = sprintf('b = %d, V = %d', b(i), V(k));
                end
            end

            title(sprintf('%s vs Average Chord for All Configurations', property_name));
            xlabel('Average Chord (in)');      % Correct axis labeling always includes the
            ylabel(sprintf('%s (%s)',property_name, unit));   % variables being plotted *and* their units!
            legend(leg);            
        end
    end
    
    hold off;
end