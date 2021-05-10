% Brian Roth
% ENGR 475 - Mechanics of Flight
% Purpose: Main code that calls disciplinary functions
%
% Instructions:
%   This code is intended to provide the basic framework for communication
%   between disciplinary functions. In specific, it models how to send and
%   receive information. The contents of each function should be replaced
%   with your own analysis code.
%
% Caution: Units are chosen for ease of interpretation. Some conversions
%   may be necessary when computing properties such as RE, L, and D.
%
% Code structure:
%   Call Controls function
%       Inputs: Wing geometry (b, S, cmac, taper)
%       Outputs: Tail sizes (S_h, AR_h, taper_h, Lt_h, Vh) for both tails
%                Neutral point
%                Control surface sizing (rudder, elevator)
%
%   Call Structures function
%       Inputs: Aircraft geometry (wing and tail sizes; fuselage length)
%       Outputs: Total weight and c.g. location
%
%   Call Aerodynamics function
%       Inputs: Wing geometry (S, b, taper)
%               Tail geometry (S, b, taper) for both tails
%               Flight velocity
%       Outputs: Drag coefficients, total drag, angle of attack (alpha)
%
%   Call Stability function
%       Inputs: CG, AR, taper, Vh, ARh, alpha (wing's angle of attack)
%       Outputs: Static margin and tail incidence angle
%
%   Call Propulsion function
%       Inputs: Flight velocity and drag
%       Outputs: Flight time and power consumption
%
%   Methods:
%       A variety of options exist for organizing your design choices
%       and communicating them between disciplinary design codes. Here are
%       a few options:
%           1. Make all of your variables global
%           2. Pass variables to/from subroutines, as needed
%           3. Create "objects" to organize info and simplify communication
%           4. Use a .mat file to store and recall design choices
%           5. Use an Excel file to store and recall design choices
%       For sake of simplicity, this code models option (2). However, feel 
%       free to adapt it to incorporate another option.

function [P, W, CG, D, CDp, CDi, alpha, Cl, SM, Btwist, time, n, xnp] = main(V, b, cavg, t, sweep_quarter)
    b = b*2.54/100;
    cavg = cavg*2.54/100;
    % Calculated properties
    S = b*cavg;     % wing area (in^2)
    AR = b^2/S;     % wing aspect ratio
    c_root = 2*b*cavg/(b*(1+t)); % wing root chord
    c_tip = t*c_root;       % wing tip chord
    cmac = (2/3)*c_root*(1+t+t^2)/(1+t);  % wing mean aerodynamic chord

    % Call Structures function
    [W, CG] = structures(b, t, c_root, sweep_quarter);
    %   Note: Structures and Controls will need to agree on how CG is defined.
    
    % Call Aerodynamics function
    [D, CDp, CDi, alpha, Cl] = aerodynamics(S, AR, t, V, W);

    % Call Stability function
    [SM, Btwist, xnp] = stability(CG, b, c_root, t, sweep_quarter, Cl);
    
    % Call Propulsion function
    [time, P, n] = propulsion(V, D);
end