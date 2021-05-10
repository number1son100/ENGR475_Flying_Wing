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

V = 5:0.1:7;
b = 42:4:50;
c = 6:2:8;

% V = 3:0.1:4;
% b = 34:4:46;
% c = 4:2:8;

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
xnp = zeros(Vlen, blen, clen);
for i = 1:blen
    for j = 1:clen
        for k = 1:Vlen
            [P(k, i, j), W(k, i, j), CG(k, i, j), D(k, i, j), CDp(k, i, j), CDi(k, i, j), alpha(k, i, j), Cl(k, i, j), SM(k, i, j), Btwist(k, i, j), time(k, i, j), n(k, i, j), xnp(k, i, j)] = main(V(k), b(i), c(j), t, sweep_quarter);
        end
    end
    
end
save('attempt')

%% Plot
load('attempt')

% options 1:
%   1 - Function of V
%   2 - Function of b
%   3 - Function of c
% options 2:
%   1 - All three
%   2 - All but the complete one
%   3 - Only the complete one

% Velocity Graphs
o1 = 1;
o2 = 1;
plot_properties(P , 'Power', 'W', V, b, c, o1, o2);
plot_properties(W , 'Weight', 'N', V, b, c, o1, 2);
plot_properties(CG , 'Center of Gravity', 'm', V, b, c, o1, o2);
plot_properties(D , 'Drag/Thrust', 'N', V, b, c, o1, o2);
plot_properties(CDp+CDi , 'Coefficient of Parasitic Drag', 'Unitless', V, b, c, o1, o2);
plot_properties(CDi , 'Coefficient of Induced Drag', 'Unitless', V, b, c, o1, o2);
plot_properties(alpha , 'Angle of Attack', 'Degrees', V, b, c, o1, o2);
plot_properties(Cl , 'Coefficient of Lift', 'Unitless', V, b, c, o1, o2);
plot_properties(SM , 'Stability Margin', 'Unitless', V, b, c, o1, o2);
plot_properties(Btwist , 'Wing Twist', 'Degrees', V, b, c, o1, o2);
plot_properties(time , 'Flight Time', 's', V, b, c, o1, o2);
plot_properties(n , 'Propeller', 'Unitless', V, b, c, o1, o2);
plot_properties(xnp , 'Neutral Point', 'm', V, b, c, o1, o2);

% Wingspan Graphs
o1 = 2;
o2 = 2;
plot_properties(P , 'Power', 'W', V, b, c, o1, o2);
plot_properties(W , 'Weight', 'N', V, b, c, o1, o2);
plot_properties(CG , 'Center of Gravity', 'm', V, b, c, o1, o2);
plot_properties(D , 'Drag/Thrust', 'N', V, b, c, o1, o2);
plot_properties(CDp , 'Coefficient of Parasitic Drag', 'Unitless', V, b, c, o1, o2);
plot_properties(CDi , 'Coefficient of Induced Drag', 'Unitless', V, b, c, o1, o2);
plot_properties(alpha , 'Angle of Attack', 'Degrees', V, b, c, o1, o2);
plot_properties(Cl , 'Coefficient of Lift', 'Unitless', V, b, c, o1, o2);
plot_properties(SM , 'Stability Margin', 'Unitless', V, b, c, o1, o2);
plot_properties(Btwist , 'Wing Twist', 'Degrees', V, b, c, o1, o2);
plot_properties(time , 'Flight Time', 's', V, b, c, o1, o2);
plot_properties(n , 'Propeller', 'Unitless', V, b, c, o1, o2);
plot_properties(xnp , 'Neutral Point', 'm', V, b, c, o1, o2);

Chord Graphs
o1 = 3;
o2 = 2;
plot_properties(P , 'Power', 'W', V, b, c, o1, o2);
plot_properties(W , 'Weight', 'N', V, b, c, o1, o2);
plot_properties(CG , 'Center of Gravity', 'm', V, b, c, o1, o2);
plot_properties(D , 'Drag/Thrust', 'N', V, b, c, o1, o2);
plot_properties(CDp , 'Coefficient of Parasitic Drag', 'Unitless', V, b, c, o1, o2);
plot_properties(CDi , 'Coefficient of Induced Drag', 'Unitless', V, b, c, o1, o2);
plot_properties(alpha , 'Angle of Attack', 'Degrees', V, b, c, o1, o2);
plot_properties(Cl , 'Coefficient of Lift', 'Unitless', V, b, c, o1, o2);
plot_properties(SM , 'Stability Margin', 'Unitless', V, b, c, o1, o2);
plot_properties(Btwist , 'Wing Twist', 'Degrees', V, b, c, o1, o2);
plot_properties(time , 'Flight Time', 's', V, b, c, o1, o2);
plot_properties(n , 'Propeller', 'Unitless', V, b, c, o1, o2);
plot_properties(xnp , 'Neutral Point', 'm', V, b, c, o1, o2);