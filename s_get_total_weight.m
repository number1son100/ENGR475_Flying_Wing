function m_total = s_get_total_weight(masses_vector)
  m_total = sum(masses_vector);
  w_total = m_total * 9.81;                     %6.6743015*10^-11;    % gravitational constant
  %fprintf("The total mass is %d kg\n",m_total)
  %fprintf("The total weight is %d N\n",w_total)
end