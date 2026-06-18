function [T2, W, n2] = turbine_mixture(species, n1, P1, T1, P2, eta)


H1 = HGSprop(species, n1, T1, P1, 'H');
S1 = HGSprop(species, n1, T1, P1, 'S');

try
    T2s = HGSisentropic(species, n1, T1, P1, 'Frozen', 'P', P2);
catch

    options = optimoptions('fsolve', 'Display', 'off', ...
                                     'FunctionTolerance', 1e-5, ...
                                     'StepTolerance', 1e-5);

    eq1 = @(T) S1 - HGSprop(species, n1, T, P2, 'S');

    T2s = fsolve(eq1, T1-100, options);
end


H2s = HGSprop(species, n1, T2s, P2, 'H');

H2 = H1 - eta * (H1 - H2s);

[T2, ~, n2, ~] = HGStp(species, n1, 'H', H2, P2);

W = (H1 - H2) * 1e-3;

end