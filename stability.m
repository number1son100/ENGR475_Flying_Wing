function [SM, Btwist, np] = stability(CG, b, rchord, taper, sweep_quarter, Cl)

Br = 13;%13; 
Bc = 6.75;%6; 
rlift_angle = -0.84;
tlift_angle = -0.27;

mean_aero_chord = (2/3)*(1+taper+taper^2)/(1+taper)*rchord;

sweep_quarter = sweep_quarter *pi/180;
   
if taper > 0.375               %neutral point from nose
    np = rchord/4 + 2*b/(3*pi) * tan(sweep_quarter);
else
    np = rchord/4 + b*(1 + 2*taper)/(6*(1 + taper)) * tan(sweep_quarter);
end
    SM = (np-CG)/mean_aero_chord;  % static margin
    
Cm = Cl*SM;
Balpha = tlift_angle - rlift_angle;

Breq = Br * (Cl *.72 / Cl) * (SM / .1);

Bcm = Bc * Cm/.05;

Btwist = Breq - Balpha - Bcm;      %geometric twist angle
    
end

