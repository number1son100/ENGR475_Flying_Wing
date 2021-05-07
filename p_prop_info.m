function [P, T_max] = p_prop_info(prop_number, v, T)
    [P, T_max] = prop_info_single(prop_number, v, T);
%     szv = size(v);
%     szT = size(T);
%     if (szv(2) ~= szT(2))
%         fprintf("Data sets of incorrect lengths were inputted into prop_info, so the function was aborted.\n")
%         P = 0;
%         T_max = 0;
%         return;
%     else
%         sz = szv(2);
%     end
%     
%     if sz == 1
%         [P, T_max] = prop_info_single(prop_number, v, T);
%     else
%         P = zeros(1, sz);
%         T_max = zeros(1, sz);
%         for i = 1:sz
%             [P(i), T_max(i)] = prop_info_single(prop_number, v(i), T(i));
%         end
%     end
end

function [P, T_max] = prop_info_single(prop_number, v, T)
    v = v*196.85039370078738;
    T = T*3.596943079091022;
    data = readtable('curvefits.xlsx');
    relevant_data = data((prop_number-1)*4+1:prop_number*4, 1:11);
    for i = 1:4
        if relevant_data{i, 2} == v
                P = relevant_data{i, 5}*T + relevant_data{i, 6};
                T_max = relevant_data{i, 11};
                break;
        elseif i == 4
            if relevant_data{i, 2} < v         % Extrapolate from endpoints
                P_low = relevant_data{i-1, 5}*T + relevant_data{i-1, 6};
                P_high = relevant_data{i, 5}*T + relevant_data{i, 6};
                P = (v-relevant_data{i-1, 2})/(relevant_data{i, 2}-relevant_data{i-1, 2})*(P_high-P_low)+P_low;
                T_max = (v-relevant_data{i-1, 2})/(relevant_data{i, 2}-relevant_data{i-1, 2})*(relevant_data{i, 11}-relevant_data{i-1, 11})+relevant_data{i-1, 11};
                break;
            else
                P = 0;
                T_max = 0;
                fprintf("You are requesting negative airspeeds. This function does not account for such situations,\nso the answers being returned are invalid.");
            end
        else
            if relevant_data{i, 2} < v && relevant_data{i+1, 2} > v
                P_low = relevant_data{i, 5}*T + relevant_data{i, 6};
                P_high = relevant_data{i+1, 5}*T + relevant_data{i+1, 6};
                P = (v-relevant_data{i, 2})/(relevant_data{i+1, 2}-relevant_data{i, 2})*(P_high-P_low)+P_low;
                T_max = (v-relevant_data{i, 2})/(relevant_data{i+1, 2}-relevant_data{i, 2})*(relevant_data{i+1, 11}-relevant_data{i, 11})+relevant_data{i, 11};
                break;
            end
        end
    end
    if T > T_max
        P = 0;
        T_max = 0;
        %fprintf("The thrust requested is in excess of the maximum thrust.");
        return;
    end
    T_max = T_max / 3.596943079091022;
end