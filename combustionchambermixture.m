function [T3, n3] = combustionchambermixture(species, n1, sp1, P1, T1, n2, P2, T2, P3, etaSQT)

Tref = 298; 

Pref= 1;

deltah1 = (NFP(sp1, 'h_pT', Pref, Tref) - NFP(sp1, 'h_pT', P1, T1)) * NFP(sp1, 'MM');

if strcmp(sp1, 'pH2')
    sp1 = 'H2';
end

h1 = HGSsingle(sp1, 'h', Tref) - deltah1;

H1= h1*sum(n1);

H2 = HGSprop(species,n2,T2,P2,'H');

H3 = H1+H2;

np= n1+n2; 

[T3id, ~, n3, ~] = HGStp(species, np, 'H', H3, P3);

T3 = T3id* (etaSQT)^2;


end