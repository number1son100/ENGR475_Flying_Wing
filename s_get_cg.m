function cg = s_get_cg(dist_mass_matrix)
    % Finds cg of large object made up of series of smaller discrete objects
    % Deals with linear things only, not lateral things
    % Takes a matrix which is used as a 2D array (list of objects with 2 values for each object)
    % where the first first component is distance to the object's cg from 
    % the front of the total object and the second component is the mass of
    % the object.
    % returns the cg of the total object.
    total_moment = 0;
    total_mass = 0;
    
    for i = 1:length(dist_mass_matrix(:,1))
       total_moment = total_moment + (dist_mass_matrix(i,1)*dist_mass_matrix(i,2));
       total_mass = total_mass + dist_mass_matrix(i,2);
    end
    
    cg = total_moment/total_mass;    
end