function [D, CDp, CDi, alpha, CL_w, Cm_u] = aerodynamics(S, AR, t, V, W)

%% CONSTANTS

FF = 1.2;       % form factor used for drag coefficient to account for surface effects during construction
rho = 1.225;    % (kg/m^3)
mu = 1.802e-5;  % (kg/m*s)
tw = -2;         % twist at the tip relative to the root chord length  (deg)
Alpha_g = 0;    % estimated geometric angle-of-attack at wing root (rad)
Alpha_L0 = -3.0;  % zero-lift angle-of-attack (rad)

%% CALCULATED VARIABLES

b_w = sqrt(AR*S);
cm_w = S/b_w;
q = 0.5*rho*V^2;                                        % dynamic pressure
REL = (rho*V) / mu;
cr = 2*S / ((1+t)*b_w);   % root chord length (m)
ct = t*cr;  % tip chord length (m)% Reynold's number per unit length

% Define Geometry Variations as a Function of Span
N = 50;                                                     % number of Fourier series terms
theta = linspace(pi/(2*N), pi/2, N);                        % (pi/2)*[1/N, 2/N, ..., N/N]
y = 0.5*b_w*cos(theta);                                     % transform from theta to y
c = cr - (cr-ct)*(2*y/b_w);                           % chord as a fcn of spanwise location
alpha_g = Alpha_g*pi/180*ones(1,N)+cos(theta)*deg2rad(tw);   % geometric angle-of-attack (rad)
alpha_L0 = Alpha_L0*pi/180*ones(1,N);                       % zero-lift angle-of-attack (rad)

%% WING DRAG CALCULATIONS

% lift
Re_w = REL * cm_w;          % Reynold's number of wing
CL_w = W/(q*S)  % lift coefficient of wing

% parasite drag
A = readmatrix('Intermediate Data A Matrix.txt');  % reading data from files that contain matrix coefficients for
B = readmatrix('Intermediate Data B Matrix.txt');  % determining coefficients for a curve fit of CDp
X = A\B;    % coefficients for CDp equation
% CDp = a0 + a1*Re + a2*CL + a3*Re^2 + a4*CL^2 + a5*Re*CL
CDp_w = X(1) + X(2).*Re_w + X(3).*CL_w + X(4).*Re_w.^2 + X(5).*CL_w.^2 + X(6).*Re_w.*CL_w

nmax=100;
n=1;
while n<nmax
    % Formulate Set of Linear Equations
    %   [a]{A} = [r]

    % induced drag
    for i = 1:N   % loop over spanwise locations
        k = 1;
        for j = 1:2:(2*N-1)   % loop over odd Fourier coefficients
            a(i,k) = ((2*b_w)/(pi*c(i)) + j/sin(theta(i))) * sin(j*theta(i));
            k = k+1;
        end
    end

    for i=1:N
        r(i) = alpha_g(i) - alpha_L0(i);
    end
    F = a\r';    % solve for the Fourier series coefficients
    
    % Solve for L and Cl distributions
    for i = 1:N   % loop over spanwise locations
        gamma(i) = 0;
        for j = 1:N   % loop over Fourier terms
            gamma(i) = gamma(i) + 2*b_w*V*F(j)*sin((2*j-1)*theta(i));
        end
        Lp(i) = rho*V*gamma(i);
    end
    cl = Lp ./ (q*c);  % section lift coefficient

    % Solve for CL, CDi, and e
    CL = pi*AR*F(1);   % wing lift coefficient
    
    sum = 0;
    for i = 2:N
        sum = sum + (2*i-1)*(F(i)/F(1))^2;
    end

    CDi_l = pi*AR*F(1)^2 * (1+sum);   % induced drag
    E = CL^2 / (pi*AR*CDi_l);  % span efficiency

    if abs(CL-CL_w)<0.001
        break
    else
        alpha_g=alpha_g-(CL-CL_w)/5;
    end

    n=n+1;
end

CDi_w = CL_w^2 / (pi * AR * E)
%S, AR, V, CL_w, CL, E, CDi_w

% angle of attack NOT QUITE SURE ABOUT THIS!!!!!!!!!
M = (2*pi) / (1+(2/(AR*E)));
alpha = (CL_w - 0.239) / M;

%% FUSELAGE DRAG CALCULATIONS

% Re_f = REL * fuse_l;
% 
% % frictional coef - this approx. assumes turbulent, incompressible flow
% Cf_fuse = 0.455 ./ (log10(Re_f)).^2.58;
% Cf_fuse = Cf_fuse * (S_fuse / S);	% nondimensionalize by wing area

%% HORIZONTAL TAIL DRAG CALCULATIONS

% Re_ht = REL * c_ht;
% A_ht = readmatrix('NACA 0006 Data A Matrix.txt');  % reading data from files that contain matrix coefficients for
% B_ht = readmatrix('NACA 0006 Data B Matrix.txt');  % determining coefficients for a curve fit of CDp
% X_ht = A_ht\B_ht;    % coefficients for CDp equation
% 
% % parasite drag
% CDp_ht = X_ht(1) + X_ht(2).*Re_ht + X_ht(3).*CL_ht + X_ht(4).*Re_ht.^2 + X_ht(5).*CL_ht.^2 + X_ht(6).*Re_ht.*CL_ht;
% CDp_ht = CDp_ht * (Sh / S);	% nondimensionalize by wing area
% 
% % induced drag
% CDi_ht = (CL_ht)^2 / (pi * ARh * E_ht);
% CDi_ht = CDi_ht * (Sh / S);	% nondimensionalize by wing area

%% VERTICAL TAIL DRAG CALCULATIONS

% CL_vt = 0;  % zero lift on the vertical tail
% c_vt = sqrt(Sv / ARv);
% Re_vt = REL * c_vt;
% E_vt = 1;
% 
% % parasite drag
% CDp_vt = X_ht(1) + X_ht(2).*Re_vt + X_ht(3).*CL_vt + X_ht(4).*Re_vt.^2 + X_ht(5).*CL_vt.^2 + X_ht(6).*Re_vt.*CL_vt;
% CDp_vt = CDp_vt .* (Sv / S);	% nondimensionalize by wing area
% 
% % induced drag
% CDi_vt = (CL_vt)^2 / (pi * ARv * E_vt);
% CDi_vt = CDi_vt * (Sv / S);	% nondimensionalize by wing area

%% TOTAL DRAG COEFFICIENT, DRAG, & LIFT

% drag coefficient
CDp = FF * (CDp_w);
CDi = CDi_w;
CD = CDp + CDi;
D = 0.5*rho*V^2*S*CD;
%c = (cr+ct)/2;
%Cm_u = W/(0.5*rho*V^2*S*c);
