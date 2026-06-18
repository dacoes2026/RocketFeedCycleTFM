function [m60, gamma60, Rg60]= Nozzleflow(species, n, T60, P60, Dthroatmain)

[gamma60, Rg60]= HGSprop(species, n, T60, P60, 'gamma', 'Rg'); %Rg provided in kJ/kg*K

Rg60= Rg60*1e3;

capitalGamma60= sqrt(gamma60)*(2/(gamma60+1))^((gamma60+1)/(2*(gamma60-1)));

%3. C* is computed

ceestarmain= sqrt(Rg60*T60)/capitalGamma60;

%4. Total mass flow rate and O2 and H2 flow rates in main nozzle are
%computed

Athroat = pi*(Dthroatmain^2)/4;

m60= ((P60*1e5)*Athroat)/ceestarmain; %Total mass flow in maiz nozzle

end