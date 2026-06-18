function [T64, v64, M64, A64, D64, F64, Isp64]=NozzleData(species, n63, v63, T63, P63, P64, Pa, m60, etanozzle, FroShift)

H63static = HGSprop(species, n63, T63, P63, 'H');

H63= H63static+(m60*(v63^2)/(2*1000));

[T64,~,n64,~,~] = HGSisentropic(species,n63,T63,P63,FroShift,'P',P64);

H64s = HGSprop(species, n64, T64, P64, 'H');

H64static = H63 - etanozzle * (H63 - H64s);

v64 = sqrt((2*1000*(H63-H64static)/m60));

[Rg64, a64] = HGSprop(species, n64, T64, P64, 'Rg', 'a');

M64= v64/a64;

rho64 = (P64*1e5)/(Rg64*1000*T64);

A64 = m60/(v64*rho64);

D64= sqrt(A64*4/pi);

F64 = (m60*v64)+(A64*(P64-Pa)*1e5);

g0= 9.807;

Isp64 = F64/(m60*g0);

D64= D64*1000;

F64= F64/1000;

end