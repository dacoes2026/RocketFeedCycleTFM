function [T2,W]= turbine(P1, T1, P2, eta, sp, mdot)

h1= NFP(sp, 'h_pt', P1, T1); %kJ/kg

s1= NFP(sp, 's_pt', P1, T1); %Specific entropy kJ/(kgK)

s2s= s1;

T2s= NFP(sp, 't_ps', P2, s2s);


h2s= NFP(sp, 'h_pt', P2, T2s); %kJ/kg

h2= h1-eta*(h1-h2s); %kJ/kg


T2= NFP(sp,'t_hp', h2, P2);

W=mdot*(h1-h2)*1e-3; %MW

end