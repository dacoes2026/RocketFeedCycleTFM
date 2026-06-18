function m60= Nozzleflowsec(sp, T60, P60, Dthroatmain)

if strcmp(sp, 'pH2') && T60>400
    sp = 'H2';
end

gamma60= (NFP(sp,'cp_pt',P60,T60))/(NFP(sp,'cv_pt',P60,T60));

R0=0.0083144621;

Rg60= R0*1000/NFP(sp,'MM');

Gamma60= sqrt(gamma60)*(2/(gamma60+1))^((gamma60+1)/(2*(gamma60-1)));

ceestarmain= sqrt(Rg60*T60)/Gamma60;

m60= ((P60*1e5)*pi*((Dthroatmain^2)/4)/ceestarmain); 

end