function [P2, T2, n2] = valve_mixture(species, n1, P1, T1, deltaP)

P2= P1/deltaP;

H1 = HGSprop(species,n1,T1,P1,'H');

H2= H1;

[T2,~,n2,~]= HGStp(species, n1, 'H', H2, P2);

end