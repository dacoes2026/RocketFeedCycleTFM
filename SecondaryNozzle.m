function [T1, P1, v1, M1, F1, Isp1, D1]= SecondaryNozzle(P0, T0, epsilon, sp, Pa, mdot, etanozzle)

g0 = 9.807;

R0=0.0083144621;

options = optimoptions('fsolve', ...
                         'Algorithm', 'levenberg-marquardt', ...
                         'FunctionTolerance', 1e-8, ...
                         'StepTolerance', 1e-10, ...
                         'Display', 'off');

gamma0= (NFP(sp,'cp_pt',P0,T0))/(NFP(sp,'cv_pt',P0,T0));

eq1= @(x) epsilon-((sqrt((gamma0-1)/2) * (2/(gamma0+1))^((gamma0+1)/(2*(gamma0-1))))/(((x/P0)^(1/gamma0))*sqrt(1- (x/P0)^((gamma0-1)/gamma0))));

P1 = fsolve(eq1, 0.2, options);

eq0=@(gamma) gammaNozzle(sp, gamma, P0, T0, P1);

gamma1= fsolve(eq0, 1.2, options);

eq2= @(M) (P0/P1)-(1+((gamma1-1)/2)*(M^2))^(gamma1/(gamma1-1));

M1= fsolve(eq2, 3);

P1= 0.4;

h0= NFP(sp, 'h_pt', P0, T0); %kJ/kg

s0= NFP(sp, 's_pt', P0, T0); %Specific entropy kJ/(kgK)

s1s= s0;

T1s= NFP(sp, 't_ps', P1, s1s);

h1s= NFP(sp, 'h_pt', P1, T1s); %kJ/kg

h1= h0-etanozzle*(h0-h1s); %kJ/kg

T1= NFP(sp, 't_hp', h1, P1);

v1= M1*sqrt(gamma1*T1*R0*1000/NFP(sp,'MM'));

gamma1= NFP(sp,'cp_pt',P1,T1)/NFP(sp,'cv_pt',P1,T1);

a1= sqrt(gamma1*R0*1000*T1/NFP(sp,'MM'));

M1= v1/a1;

rho1 = (P1*1e5)/(R0*1000*T1/NFP(sp,'MM')); 

A1 = mdot/(v1*rho1); 

D1= sqrt(A1*4/pi);

F1= (mdot*v1)+(A1*((P1-Pa)*1e5));

Isp1= F1/(mdot*g0);

F1= F1/1000;

D1= D1*1000;

end