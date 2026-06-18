function  R= gammaNozzle(sp, gamma60, P60, T60, P64)


eq2= @(M) (P60/P64)-(1+((gamma60-1)/2)*(M^2))^(gamma60/(gamma60-1));
 
M64= fsolve(eq2, 3);

T64= T60/(1+((gamma60-1)/2)*(M64^2));

R= ((NFP(sp,'cp_pt',P64,T64))/(NFP(sp,'cv_pt',P64,T64)))-gamma60;

end