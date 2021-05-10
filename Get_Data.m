t = 0.42;
sweep_quarter = 25.8;
best = [5.5, 42, 6];
[P, W, CG, D, CDp, CDi, alpha, Cl, SM, Btwist, time, n, xnp] = main(best(1), best(2), best(3), t, sweep_quarter);
best = [best,P, W, CG, D, CDp, CDi, alpha, Cl, SM, Btwist, time, n, xnp];

fprintf("The optimal configuration is b=%d in and c=%d in with propeller %d at an airspeed of v=%d m/s, taking P=%d W of power.", [best(3), best(2), best(15), best(1), best(4)]);
fprintf("This yields a flight time of %d minutes. The static margin is %d\n", [best(14), best(12)]);
fprintf("This gives a weight estimate of %d N, a center of gravity at %d m from the leading edge of the plane, and a wing twist of %d degrees.\n", [best(5), best(6), best(13)]);