function [T5, n5] = combustionchamber4flows(species, n1, P1, T1, n2, P2, T2, n3, sp3, P3, T3, n4, sp4, P4, T4, P5, etaSQT)

Tref = 298; 

Pref= 1; 

H1= HGSprop(species, n1, T1, P1, 'H');

H2= HGSprop(species, n2, T2, P2, 'H');

deltah3 = (NFP(sp3, 'h_pT', Pref, Tref) - NFP(sp3, 'h_pT', P3, T3)) * NFP(sp3, 'MM');

if strcmp(sp3, 'pH2')
    sp3 = 'H2';
end

h3 = HGSsingle(sp3, 'h', Tref) - deltah3;

deltah4 = (NFP(sp4, 'h_pT', Pref, Tref) - NFP(sp4, 'h_pT', P4, T4)) * NFP(sp4, 'MM');

if strcmp(sp4, 'pH2')
    sp4 = 'H2';
end

h4 = HGSsingle(sp4, 'h', Tref) - deltah4;

H5 = H1+H2+(sum(n3)*h3)+(sum(n4)*h4);

np = n1+n2+n3+n4; 

[T5id, ~, n5, ~] = HGStp(species, np, 'H', H5, P5);

T5 = T5id* (etaSQT)^2;


end