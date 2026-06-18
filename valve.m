function [P2, T2]= valve(P1, T1,deltaP, sp)

if strcmp(sp, 'pH2') && T1>400
    sp = 'H2';
end

P2= P1/deltaP;

h1= NFP(sp, 'h_pt', P1, T1);

h2= h1;

try
    T2 = NFP(sp, 't_hp', h2, P2);
catch ME
    % Emergency fallback: If it still fails on pH2, force H2 and retry
    if strcmp(sp, 'pH2')
        sp = 'H2';
        h1 = NFP(sp, 'h_pt', P1, T1);
        T2 = NFP(sp, 't_hp', h1, P2);
    else
        rethrow(ME); % If it's a real error unrelated to the pH2 limit, show it
    end
end

end