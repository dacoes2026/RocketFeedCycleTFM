clc
clear
close all

%SSME_14_Pa_119.pdf

%Space Shuttle Main Engine

%Input data

data.eta25= 0.650;
data.eta95= 1;
data.eta34= 0.520;
data.eta46= 0.780;
data.eta96= 1;
data.eta26= 0.730;
data.eta10= 0.630;
data.eta90= 1;
data.eta15= 0.620;
data.eta41= 0.780;
data.eta92= 1;
data.eta13= 0.670;
data.eta18= 0.800;

data.deltaP28= 1.074;
data.deltaP32= 1.341;
data.deltaP68= 1.013;
data.deltaP67= 1.157;
data.deltaP59= 1.053;
data.deltaP62= 1.151;
data.deltaP21= 1.240;
data.deltaP31= 1.102;
data.deltaP64= 1.050;
data.deltaP36= 1.074;
data.deltaP47= 1.077;
data.deltaP76= 1.134;
data.deltaP17= 1.233;
data.deltaP42= 1.077;
data.deltaP58= 1.053;
data.deltaP63= 1.163;
data.deltaP38= 1.114;
data.deltaP20= 1.221;
data.deltaP61= 1.182;
data.deltaP70= 285.53/2.49;
data.deltaP73= 261.36/3.51;
data.etacstar=0.995;
data.etaSQT=0.993;
data.P18 = 558.71; 
data.P37 = 431.40;
data.T37 = 163.3;
data.T18 = 116.8;
data.P40 = 387.25; 
data.P41= 251.43; %bar
data.T41= 760.9;
data.Q68= 0.4051e3; %kW
data.T34= 244.8; 
data.P34= 261.36;
data.P48= 248.21; 
data.P45= 391.47;
data.P46= 248.21;
data.P49= 248.21;
data.T13= 108.9;
data.P13= 330.35;
data.P50= 230.40;
data.Pa=0; %Vacuum conditions
data.PS63= 219.70;
data.TS63= 3603.6;
data.vS63= 326.8; 
data.MS63= 0.206;
data.AS63= 0.1562;
data.P51= 129.26;
data.Q32= 47.76e3; %kW
data.Q28= 93.13e3; %kW
data.P54= 0.19243; %bar
data.PO2= 6.89;
data.TO2= 91.1;
data.TH2= 20.6;
data.PH2= 2.07;
data.P25=19.5;
data.P26= 486.49;
data.P10= 29.7; 
data.T15= 107.8;
data.P12= 29.7;
data.T12= 94.8;
data.P52= 129.26;
data.T52= 3378.8;
data.v52= 1534.4;
data.M52= 1.002;
data.A52= 0.0525;

data.P53= 129.26;
data.T53= 3350.2;
data.v53= 1534.4;
data.M53= 1.007;
data.A53= 0.0519;
data.P4P1= 0.977; 

data.T25= 22.7;
data.P73= 3.51;
data.T73= 252.1;
data.T34= 244.8;
data.T45= 1105.6;
data.T46= 1008.9;
data.T49= 975;
data.T26= 57.3;
data.T64= 59.1;
data.P64= 463.32;
data.P36= 431.40;
data.T36= 61.4;
data.P28= 431.40;
data.T28= 257.8;
data.T37= 163.3;
data.P32= 345.50;
data.T32= 252.8;
data.T50= 3615.8;
data.T51= 3393.1;
data.tau73= 0.35/15.46;
data.tau59= 1.90/15.11;
data.tau58= 0.47/13.22;
data.tau38= 19.94/57.76;
data.tau32= 15.46/73.22;
data.tau36= 28.88/57.76;
data.tau15= 83.06/522.40;
data.tau67= 0.75/439.34;
data.tau18= 50.46/438.59;
data.tau61= 13.56/50.16;
data.T54= 1139.3;
data.v54= 4351.2;
data.A54= 4.0894;
data.M54= 4.734;
data.v51= 1534.4;
data.M51= 1;
data.A51= 0.0528;
data.PS62= 225.10;
data.TS62= 3613.5;
data.T48= 748.2;
data.P70= 2.49;
data.T70= 494;
data.P67= 285.53;
data.T67= 507.8; 
data.P68= 248.21;
data.T68= 759.5;
data.T18= 116.8;
data.T40= 833.3;
data.T15= 107.8;
data.T10= 92.3;
data.W10= -1.396;
data.W15= 1.396;
data.W41= 21.77;
data.W13= -20.51;
data.W18= -1.263;
data.W26= -57.79;
data.W46= 57.79;
data.W34= 2.755;
data.W25= -2.755;
data.OF=439.34/73.22;
data.DS63= 0.4459;
data.D51= 0.2592;
data.epsilon= 4.0894/0.0528;

BaselineValues = [
    data.P34; data.T34; data.P13; data.T13; data.P37; data.T37; ...
    data.P25; data.P10; data.T25; data.W25; data.T26; data.W26; ...
    data.P64; data.T64; data.P36; data.T36; data.P28; data.T28; ...
    data.P45; data.T45; data.T46; data.W46; data.W34; data.P73; ...
    data.T73; data.P49; data.T49; data.P32; data.T32; data.T10; ...
    data.W10; data.T15; data.W15; data.P12; data.T12; data.W13; ...
    data.T18; data.W18; data.P40; data.T40; data.T41; data.W41; ...
    data.P68; data.T68; data.P67; data.T67; data.P70; data.T70; ...
    data.P50; data.T50; data.PS62; data.TS62; data.PS63; data.TS63; ...
    data.vS63; data.MS63; data.AS63; data.P51; data.T51; data.v51; ...
    data.M51; data.A51; data.P52; data.T52; data.v52; data.M52; ...
    data.A52; data.P53; data.T53; data.v53; data.M53; data.A53; ...
    data.P54; data.T54; data.v54; data.M54; data.A54; data.T48; ...
    data.P48; data.P18; data.P26; data.P41; data.P46
];

%x0 = [261.36,  244.88,  330.35,   108.9,  431.4,  163.3,  195,  297]; %The
%results that are supposed to be found

x0 = [230.0,  215.0,  290.0,   95.0,  370.0,  140.0,  150,  220];

lb = [150.0,  150.0,  200.0,   60.0,  150,   90.0,   80,  100];

ub = [500,  350.0,  500,  200.0,  600,  450,  400,  800];

options = optimoptions('lsqnonlin', ...
    'Display', 'iter', ...           
    'FiniteDifferenceType', 'forward', ... 
    'FiniteDifferenceStepSize', 1e-4, ...  
    'FunctionTolerance', 1e-7, ...         
    'StepTolerance', 1e-7, ...             
    'OptimalityTolerance', 1e-6, ...       
    'MaxFunctionEvaluations', 3000, ...  
    'MaxIterations', 200);

xfinal = lsqnonlin(@(x) EngineResidual2(x, data), x0, lb, ub, options);

P34= xfinal(1);
T34= xfinal(2);
P13= xfinal(3);
T13= xfinal(4);
P37= xfinal(5);
T37= xfinal(6);
P25= xfinal(7)/10;
P10= xfinal(8)/10;

errorP34=((P34-data.P34)/data.P34)*100;
errorT34=((T34-data.T34)/data.T34)*100;
errorP13=((P13-data.P13)/data.P13)*100;
errorT13=((T13-data.T13)/data.T13)*100;
errorP37=((P37-data.P37)/data.P37)*100;
errorT37=((T37-data.T37)/data.T37)*100;
errorP25=((P25-data.P25)/data.P25)*100;
errorP10=((P10-data.P10)/data.P10)*100;

data.P34= P34;
data.T34= T34;
data.P13= P13;
data.T13= T13;
data.P37= P37;
data.T37= T37;
data.P25= P25;
data.P10= P10;

results= ResultsComputation2(data);


errorT25=((results.T25-data.T25)/data.T25)*100;
errorW25=((results.W25-data.W25)/data.W25)*100;
errorT26=((results.T26-data.T26)/data.T26)*100;
errorW26=((results.W26-data.W26)/data.W26)*100;
errorP64= ((results.P64-data.P64)/data.P64)*100;
errorT64= ((results.T64-data.T64)/data.T64)*100;
errorP36= ((results.P36-data.P36)/data.P36)*100;
errorT36= ((results.T36-data.T36)/data.T36)*100;
errorP28= ((results.P28-data.P28)/data.P28)*100;
errorT28= ((results.T28-data.T28)/data.T28)*100;
errorP45= ((results.P45-data.P45)/data.P45)*100;
errorT45= ((results.T45-data.T45)/data.T45)*100;
errorT46=((results.T46-data.T46)/data.T46)*100;
errorW46=((results.W46-data.W46)/data.W46)*100;
errorW34=((results.W34-data.W34)/data.W34)*100;
errorP73= ((results.P73-data.P73)/data.P73)*100;
errorT73= ((results.T73-data.T73)/data.T73)*100;
errorP49= ((results.P49-data.P49)/data.P49)*100;
errorT49= ((results.T49-data.T49)/data.T49)*100;
errorP32= ((results.P32-data.P32)/data.P32)*100;
errorT32= ((results.T32-data.T32)/data.T32)*100;
errorT10=((results.T10-data.T10)/data.T10)*100;
errorW10=((results.W10-data.W10)/data.W10)*100;
errorT15=((results.T15-data.T15)/data.T15)*100;
errorW15=((results.W15-data.W15)/data.W15)*100;
errorP12= ((results.P12-data.P12)/data.P12)*100;
errorT12= ((results.T12-data.T12)/data.T12)*100;
errorW13=((results.W13-data.W13)/data.W13)*100;
errorT18=((results.T18-data.T18)/data.T18)*100;
errorW18=((results.W18-data.W18)/data.W18)*100;
errorP40= ((results.P40-data.P40)/data.P40)*100;
errorT40= ((results.T40-data.T40)/data.T40)*100;
errorT41=((results.T41-data.T41)/data.T41)*100;
errorW41=((results.W41-data.W41)/data.W41)*100;
errorP68= ((results.P68-data.P68)/data.P68)*100;
errorT68= ((results.T68-data.T68)/data.T68)*100;
errorP67= ((results.P67-data.P67)/data.P67)*100;
errorT67= ((results.T67-data.T67)/data.T67)*100;
errorP70= ((results.P70-data.P70)/data.P70)*100;
errorT70= ((results.T70-data.T70)/data.T70)*100;
errorP50= ((results.P50-data.P50)/data.P50)*100;
errorT50= ((results.T50-data.T50)/data.T50)*100;
errorPS62= ((results.PS62-data.PS62)/data.PS62)*100;
errorTS62= ((results.TS62-data.TS62)/data.TS62)*100;
errorPS63=((results.PS63-data.PS63)/data.PS63)*100;
errorTS63=((results.TS63-data.TS63)/data.TS63)*100;
errorvS63=((results.vS63-data.vS63)/data.vS63)*100;
errorMS63=((results.MS63-data.MS63)/data.MS63)*100;
errorAS63=((results.AS63-data.AS63)/data.AS63)*100;
errorP51=((results.P51-data.P51)/data.P51)*100;
errorT51=((results.T51-data.T51)/data.T51)*100;
errorv51=((results.v51-data.v51)/data.v51)*100;
errorM51=((results.M51-data.M51)/data.M51)*100;
errorA51=((results.A51-data.A51)/data.A51)*100;
errorP52= ((results.P52-data.P52)/data.P52)*100;
errorT52= ((results.T52-data.T52)/data.T52)*100;
errorv52=((results.v52-data.v52)/data.v52)*100;
errorM52=((results.M52-data.M52)/data.M52)*100;
errorA52=((results.A52-data.A52)/data.A52)*100;
errorP53= ((results.P53-data.P53)/data.P53)*100;
errorT53= ((results.T53-data.T53)/data.T53)*100;
errorv53=((results.v53-data.v53)/data.v53)*100;
errorM53=((results.M53-data.M53)/data.M53)*100;
errorA53=((results.A53-data.A53)/data.A53)*100;
errorP54=((results.P54-data.P54)/data.P54)*100;
errorT54=((results.T54-data.T54)/data.T54)*100;
errorv54=((results.v54-data.v54)/data.v54)*100;
errorM54=((results.M54-data.M54)/data.M54)*100;
errorA54=((results.A54-data.A54)/data.A54)*100;
errorT48= ((results.T48-data.T48)/data.T48)*100;
errorP48= ((results.P48-data.P48)/data.P48)*100;
errorP18= ((results.P18-data.P18)/data.P18)*100;
errorP26= ((results.P26-data.P26)/data.P26)*100;
errorP41= ((results.P41-data.P41)/data.P41)*100;
errorP46= ((results.P46-data.P46)/data.P46)*100;


%Results are printed in table format
RowNames = {
    'P34 [bar]'; 'T34 [K]'; 'P13 [bar]'; 'T13 [K]'; 'P37 [bar]'; 'T37 [K]'; ...
    'P25 [bar]'; 'P10 [bar]'; 'T25 [K]'; 'W25 [MW]'; 'T26 [K]'; 'W26 [MW]'; ...
    'P64 [bar]'; 'T64 [K]'; 'P36 [bar]'; 'T36 [K]'; 'P28 [bar]'; 'T28 [K]'; ...
    'P45 [bar]'; 'T45 [K]'; 'T46 [K]'; 'W46 [MW]'; 'W34 [MW]'; 'P73 [bar]'; ...
    'T73 [K]'; 'P49 [bar]'; 'T49 [K]'; 'P32 [bar]'; 'T32 [K]'; 'T10 [K]'; ...
    'W10 [MW]'; 'T15 [K]'; 'W15 [MW]'; 'P12 [bar]'; 'T12 [K]'; 'W13 [MW]'; ...
    'T18 [K]'; 'W18 [MW]'; 'P40 [bar]'; 'T40 [K]'; 'T41 [K]'; 'W41 [MW]'; ...
    'P68 [bar]'; 'T68 [K]'; 'P67 [bar]'; 'T67 [K]'; 'P70 [bar]'; 'T70 [K]'; ...
    'P50 [bar]'; 'T50 [K]'; 'PS62 [bar]'; 'TS62 [K]'; 'PS63 [bar]'; 'TS63 [K]'; ...
    'vS63 [m/s]'; 'MS63'; 'AS63 [m^2]'; 'P51 [bar]'; 'T51 [K]'; 'v51 [m/s]'; ...
    'M51'; 'A51 [m^2]'; 'P52 [bar]'; 'T52 [K]'; 'v52 [m/s]'; 'M52'; ...
    'A52 [m^2]'; 'P53 [bar]'; 'T53 [K]'; 'v53 [m/s]'; 'M53'; 'A53 [m^2]'; ...
    'P54 [bar]'; 'T54 [K]'; 'v54 [m/s]'; 'M54'; 'A54 [m^2]'; 'T48 [K]'; ...
    'P48 [bar]'; 'P18 [bar]'; 'P26 [bar]'; 'P41 [bar]'; 'P46 [bar]'
};

% 2. Results are extracted as a matrix
SolvedValues = [
    results.P34; results.T34; results.P13; results.T13; results.P37; results.T37; ...
    results.P25; results.P10; results.T25; results.W25; results.T26; results.W26; ...
    results.P64; results.T64; results.P36; results.T36; results.P28; results.T28; ...
    results.P45; results.T45; results.T46; results.W46; results.W34; results.P73; ...
    results.T73; results.P49; results.T49; results.P32; results.T32; results.T10; ...
    results.W10; results.T15; results.W15; results.P12; results.T12; results.W13; ... 
    results.T18; results.W18; results.P40; results.T40; results.T41; results.W41; ...
    results.P68; results.T68; results.P67; results.T67; results.P70; results.T70; ...
    results.P50; results.T50; results.PS62; results.TS62; results.PS63; results.TS63; ...
    results.vS63; results.MS63; results.AS63; results.P51; results.T51; results.v51; ...
    results.M51; results.A51; results.P52; results.T52; results.v52; results.M52; ...
    results.A52; results.P53; results.T53; results.v53; results.M53; results.A53; ...
    results.P54; results.T54; results.v54; results.M54; results.A54; results.T48; ...
    results.P48; results.P18; results.P26; results.P41; results.P46
];

BaselineValues = BaselineValues(1:length(SolvedValues));

% 4. Errors are extracted
RelativeErrors_pct = [
    errorP34; errorT34; errorP13; errorT13; errorP37; errorT37; ...
    errorP25; errorP10; errorT25; errorW25; errorT26; errorW26; ...
    errorP64; errorT64; errorP36; errorT36; errorP28; errorT28; ...
    errorP45; errorT45; errorT46; errorW46; errorW34; errorP73; ...
    errorT73; errorP49; errorT49; errorP32; errorT32; errorT10; ...
    errorW10; errorT15; errorW15; errorP12; errorT12; errorW13; ...
    errorT18; errorW18; errorP40; errorT40; errorT41; errorW41; ...
    errorP68; errorT68; errorP67; errorT67; errorP70; errorT70; ...
    errorP50; errorT50; errorPS62; errorTS62; errorPS63; errorTS63; ...
    errorvS63; errorMS63; errorAS63; errorP51; errorT51; errorv51; ...
    errorM51; errorA51; errorP52; errorT52; errorv52; errorM52; ...
    errorA52; errorP53; errorT53; errorv53; errorM53; errorA53; ...
    errorP54; errorT54; errorv54; errorM54; errorA54; errorT48; ...
    errorP48; errorP18; errorP26; errorP41; errorP46
];

%The results table is setup
PerformanceSummaryTable = table(BaselineValues, SolvedValues, RelativeErrors_pct, ...
    'RowNames', RowNames, ...
    'VariableNames', {'Baseline_Reference', 'Solver_Output', 'Relative_Error_Percent'});

%The table itself is computed
fprintf('\n\n=========================================================================\n');
fprintf('                SSME ENGINE SYSTEM MODEL ERROR ASSESSMENT\n');
fprintf('=========================================================================\n\n');
disp(PerformanceSummaryTable);
fprintf('=========================================================================\n');