function [W, cg] = structures(l_wing, taper, l_chord_root, z_sweep_quarter)
    % NOTE: This function returns total mass not total weight!
    % Inputs:
        %   l_wing                      Wingspan (total, tip to tip)
        %   taper = C_tip/C_root        Wing Taper
        %   l_chord_root                Wing root chord length
        %   z_sweep_quarter             Wing quarter chord sweep angle
        %   wing_geometric_centroid     Geometric centroid of airfoil relative to front of airfoil with unit length chord - considered cg of airfoil
        %   a_airfoil_characteristic    Area of airfoil with unit length chord (1 meter)
        
    % Need to adjust weight for increased wing length by taking into
    % account sweep angle

    %% Info
        % Author: Caleb Nelson
        % Last Edit: 5/6/2021
        % Revision: 6
        % This version has the tail code removed, see previous version
        % where it was only commented out if you want it
    
    %% About and General Info
        % This code takes a set of inputs for the design of a flying wing,
        % of a model aircraft and calculates the center of gravity and 
        % total mass based off of values of components used for model
        % aircraft built at WWU
        % The front of the wing is consider 0 x position.  Towards the 
        % rear is the positive direction

    %% Assumptions
        % The following assumptions are made:
        %   1. All measurements and values are in metric standard SI units
        %   2. The aircraft is balanced laterally
        %   3. The payload is placed at the final CG found without the payload, so
        %   adding the payload does not move or shift the CG
        %   4. The plane adheres to a flying wing design and does not have a
        %   tail

    %% Code Conventions

        % Prefixes
        % m_ masses
        % d_ densities
        % p_ perimiters
        % a_ areas
        % v_ volumes
        % l_ lengths
        % t_ thicknesses
        % x_ position value -- front to back, often times distance to CG of object from front tip of plane
        % y_ position value -- across plane, lateral dimension
        % z_ angles
        % num_ counts

        % Affixes
        % _avg averages
        % _t totals

        %% Assumptions/Other Inputs
        % Things that could be inputs but aren't becuase we have to make the
        % function fit the specified prototype
        
        wing_geometric_centroid = 0.3866;           % Geometric centroid of airfoil relative to front of airfoil with unit length chord - considered cg of airfoil
        a_airfoil_characteristic = 0.0608;          % area of airfoil with unit length chord (1 meter)
        % Payload
        m_payload_t = 0.100;                        % payload mass in kg
    
        % Balsa Sheet (goes between wings to add strength like a biscuit
        % joint and provides an area to place our components in)
        l_balsa_sheet_width = 0.12;
        l_balsa_sheet_length = 0.12;
        x_balsa_sheet = 0.08;                      % Distance to cg of balsa sheet from front tip of aircraft


    %% Calculated values / Convert Inputs
        % Convert given values to the values we used internally
        
        % Convert quarter chord sweep angle to front sweep angle
        z_sweep_front = atand(tand(z_sweep_quarter)+1/(2*l_wing)*(l_chord_root-taper*l_chord_root));                   % sweep angle for front of airfoil
            
        % Wing and airfoil geometry (m)
        l_chord_tip = taper * l_chord_root;      % tip chord length
    
        
    %% Constants

        % Thicknesses (m)
        t_balsa_sheet = 0.0015875;                     % Thickness of flat sheets (used for airfoils, flat stringers, and maybe tail and stuff)

        % Masses (kg)
        m_extra = 0.0;
        m_motor = 0.01048;
        m_servo = 0.00244;
        m_esc = 0.00743;
        m_capture_nut = 0.00034;
        m_motor_mount = 0;                      % Ignored for now
        m_servo_extender = 0;                   % Ignored for now
        m_control_arm = 0.00085;
        m_control_horn_small = 0.00025;
        m_control_horn_large = 0.0005;
        m_hinge = 0.00025;
        m_battery = 0.01149;                    % Can also use 12.82 g

        % Densities (kg/m^3)
        d_balsa_sheet = 32.1522;
        d_foam = 24.10226;
        
        
    %% Position Values
        % x positions to centers of gravity of each discrete object
        x_extra = 0.07;
        x_motor = 11.27*2.54/100;
        x_servo_1 = 0.07;
        x_servo_2 = 0.07;
        x_esc = 0.06;
        x_battery = 0.06;
        x_motor_mount = 11.27*2.54/100;
        

    %% Basic Calculations

%         % Wing and airfoil geometry
%         l_chord_avg = (l_chord_root+l_chord_tip)/2;             % avg chord length
%         a_airfoil = a_airfoil_characteristic * l_chord_avg^2;   % airfoil area
%         a_wing_surface = l_wing * l_chord_avg * 2 ;             % total surface area of wing, top and bottom

        % Balsa sheet
        m_balsa_sheet = l_balsa_sheet_length * l_balsa_sheet_width * t_balsa_sheet * d_balsa_sheet;     % mass of balsa sheet


    %% Wing CG
    
    % Calculations for a single section
    num_sections = 100;
    
    % Figure out parameters for each section
    l_section_width = l_wing/2/num_sections;                             % Width of each section
    
    wing_dist_mass_matrix = zeros(num_sections,2);
    
    % Calculate CG for num_sections sections on a single wing
    for i = 0:1:(num_sections-1)
        % Basic calculations
        y_section_start_pos = i*l_section_width;                         % Lateral distance to start of section
        y_section_pos = y_section_start_pos + (l_section_width/2);       % Lateral distance to center of section
        % Everything here after deals with the center of each section
        l_section_chord = l_chord_root-y_section_pos/(l_wing/2)*(l_chord_root-l_chord_tip); % Chord length of section (at center of section)
        a_cross_section = a_airfoil_characteristic * l_section_chord^2;  % Cross sectional area of section (at center of section)
        x_section_offset = y_section_pos*tand(z_sweep_front);             % Distance from front of plane to start of this sectoin (at center of section)

        % Section mass
        m_section_foam = l_section_width * a_cross_section * d_foam;     % Mass of foam in each section
        m_section_t = m_section_foam;                                    % Total mass for each section - currenlty the same as the foam, but we may want to add tape weight later
        
        % Section CG
        x_section_relative_cg = l_section_chord * wing_geometric_centroid;     % Distance to cg of section relative to front of section (at center of section)
        x_section_final_cg = x_section_offset + x_section_relative_cg;         % Final cg for section relative to front of wing
        
        % Add these distance (to CG) and mass values to the total
        wing_dist_mass_matrix(i+1,:) = [x_section_final_cg, m_section_t];
    end
    
    % Get final wing CG
    x_wing = s_get_cg(wing_dist_mass_matrix);                           % Final wing CG
    
    % Get final wing mass
    m_wing_t = 2*s_get_total_mass(wing_dist_mass_matrix(:,2));        % Total wing weight
    %% Get Final CG
        total_dist_mass_matrix = [
            x_extra, m_extra;
            x_motor, m_motor;
            x_servo_1, m_servo;
            x_servo_2, m_servo;
            x_esc, m_esc;
            x_motor_mount, m_motor_mount;
            x_battery, m_battery;
            x_wing, m_wing_t
            x_balsa_sheet, m_balsa_sheet];
        cg = s_get_cg(total_dist_mass_matrix);

        %fprintf("The center of gravity is %d meters back from the front of the fuselage stick\n", cg)

    %% Get Final Mass
        masses_vector = [m_extra
            m_motor;
            (m_servo*2);
            m_esc;
            (m_capture_nut*2);
            m_motor_mount;
            (m_servo_extender*2);
            (m_control_arm*2);
            (m_control_horn_small*2);
            (m_control_horn_large*2);
            (m_hinge*4);
            m_battery;
            m_wing_t;
            m_payload_t;
            m_balsa_sheet];
        m = s_get_total_mass(masses_vector);
        W = m*9.81;
        %fprintf("The total mass is %d kg\n", m)
end