function [T3, n3]= combustionchamber(species, sp1, sp2, n1, n2, P1, T1, P2, T2, P3, etacstar)


if strcmp(sp1, 'pH2') && T1 > 400
    sp1 = 'H2';
end
if strcmp(sp2, 'pH2') && T2 > 400
    sp2 = 'H2';
end

np= zeros(length(species),1);
np(1)= n1;
np(2)= n2;

Tref= 298;
Pref=1;

deltah1 = (NFP(sp1, 'h_pT', Pref, Tref) - NFP(sp1, 'h_pT', P1, T1)) * NFP(sp1, 'MM');

if strcmp(sp1, 'pH2')
    sp1 = 'H2';
end
h1 = HGSsingle(sp1, 'h', Tref) - deltah1;

deltah2 = (NFP(sp2, 'h_pT', Pref, Tref) - NFP(sp2, 'h_pT', P2, T2)) * NFP(sp2, 'MM');

if strcmp(sp2, 'pH2')
    sp2 = 'H2';
end

h2 = HGSsingle(sp2, 'h', Tref) - deltah2;

H3 = (np(1) * h1 + np(2) * h2);

[T3id, ~, n3, ~] = HGStp(species, np, 'H', H3, P3);

T3 = T3id* (etacstar)^2;
end