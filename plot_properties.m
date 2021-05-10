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