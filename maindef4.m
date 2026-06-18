clc
clear
close all

%RD-0120 engine

data.PO2= 3;
data.TO2= 91;
data.mO2= 376.71;

data.P10= 30;
data.T10= 92.7;
data.W10= -1.623; %MW
data.eta10= 0.550;


data.P12= 30; %bar
data.T12= 97.7; %K
data.m12= 448.17; %kg/s

data.m18= 110.62; %kg/s
data.P18= 584.06; %bar
data.T18= 121.1; %K
data.W18= -7.446; %MW
data.eta18= 0.720; 

data.m15= 71.46; %kg/s
data.m19= 39.17; %kg/s

data.P15= 30; %bar
data.T15= 122.6; %K
data.W15= 1.632; %MW
data.eta15= 0.450;

data.deltaP19= 1.120; 
data.P19= 521.48; %bar
data.T19= 123.3; %K

data.deltaP38= 1.250;

data.m13= 337.55; %kg/s
data.P13= 351.97; %bar
data.T13= 108.7; %K
data.eta13= 0.810;
data.W13= -11.87; %MW

data.deltaP17= 1.260;

data.deltaP21= 1.250;


data.PH2= 3; %bar
data.TH2= 21; %K
data.mH2= 62.79; %kg/s

data.P25= 17.58; %bar
data.T25= 23; %K
data.eta25= 0.600;
data.W25= -2.154; %MW

data.eta95= 1;
data.eta90= 1;
data.eta92=1;

data.P26= 458.90; %bar
data.T26= 56.4; %K
data.eta26= 0.730; 
data.W26= -47.32; %MW

data.deltaP20= 1.1;
data.m34= 48.49; %kg/s

data.deltaP23= 1.1;
data.P23= 417.9; %bar
data.T23= 59.5; %K
data.m23= 14.30; %kg/s

data.deltaP28= 1.320; 
data.Q28= 50e3; %kW
data.P28= 316.05; %bar
data.T28= 277.6; %K

data.P17= 279.34;
data.T17= 111.2;

data.deltaP29= 1.150; 
data.Q29= 70e3; %kW
data.P29= 274.83; %bar
data.T29= 607.5; 


data.P34= 250.29; %bar
data.T34= 598.6; %K
data.eta34= 0.600;
data.W34= 2.154; %MW

data.deltaP35= 1.120;

data.eta40= 0.980;
data.P40= 417.19; %bar
data.T40= 822; %K
data.m40= 87.66; %kg/s

data.P41= 243.59; %bar
data.T41= 731.1; %K
data.W41= 66.64; %MW
data.eta41= 0.810;

data.deltaP42= 1.090;

data.P50= 223.47; %bar
data.T50= 3588.3; %K
data.eta50= 0.990;

data.PS62= 218.60; %bar
data.TS62= 3586.1; %K
data.deltaPS62= 223.47/218.6;

data.PS63= 213.63; %bar
data.TS63= 3576.8; %K
data.vS63= 316.8; %m/s
data.MS63= 0.200;
data.AS63= 0.1414; %m^2

data.P51= 125.47; %bar
data.T51= 3365.1; %K
data.v51=  1529.4; %m/s
data.M51= 1;
data.A51= 0.0465; %m^2

data.P52= 125.47; %bar
data.T52= 3347.2; %K
data.v52= 1529.4; %m/s
data.M52= 1.003;
data.A52= 0.0462;%m^2

data.P53= 125.47; %bar
data.T53= 3321.6; %K
data.v53= 1529.4;
data.M53= 1.007;
data.A53= 0.0458;

data.P54= 0.16210; %bar
data.T54= 1085.5; %K
data.v54= 4349.4; %m/s
data.M54= 4.832;
data.A54= 3.9865; %m^2

data.etacstar40= 0.980;
data.etacstar50= 0.990;

data.DS63= 0.4243; %m
data.D51= 0.2434;
data.Pa=0;
data.OF= 376.71/62.79;
data.deltaP26= 458.90/17.58;

data.tau18= 110.62/448.17;
data.tau19= 39.17/110.62;
data.tau23= 14.30/62.79;

PO2= data.PO2;
TO2= data.TO2;
P10= data.P10;
eta10= data.eta10;
mO2= data.mO2;
eta25= data.eta25;
PH2= data.PH2;
TH2= data.TH2;
P25= data.P25;
mH2= data.mH2;
P26= data.P26;
eta26= data.eta26;
deltaP20= data.deltaP20;
deltaP23= data.deltaP23;
Q28= data.Q28;
deltaP28= data.deltaP28;
Q29= data.Q29;
deltaP29= data.deltaP29;
P34= data.P34;
eta34= data.eta34;
T15= data.T15;
P18= data.P18;
eta18= data.eta18;
eta15= data.eta15;
deltaP19= data.deltaP19;
deltaP38= data.deltaP38;
etacstar40= data.etacstar40;
etacstar50= data.etacstar50;
eta41= data.eta41;
P41= data.P41;
deltaP42= data.deltaP42;
P13= data.P13;
eta13= data.eta13;
deltaP17= data.deltaP17;
deltaP35= data.deltaP35;
deltaP21= data.deltaP21;
PS62= data.PS62;
DS63= data.DS63;
D51= data.D51;
P54= data.P54;
deltaPS62= data.deltaPS62;

Pa= data.Pa;

BaselineValues = [
    data.P12; data.T12; data.P26; data.P13; data.P25; data.T34; ...
    data.T25; data.W25; data.T26; data.W26; data.P29; data.T29; ...
    data.W34; data.T10; data.W10; data.T18; data.W18; data.T15; ...
    data.W15; data.P19; data.T19; data.T40; data.T41; data.W41; ...
    data.T13; data.W13; data.T50; data.TS62; data.PS63; data.TS63; ...
    data.vS63; data.MS63; data.AS63; data.P51; data.T51; data.v51; ...
    data.M51; data.A51; ...
    data.P52; data.T52; data.v52; data.M52; data.A52; ...  
    data.P53; data.T53; data.v53; data.M53; data.A53; ...  
    data.P54; data.T54; data.v54; data.M54; data.A54; ...
    data.P17; data.T17; data.P28; data.T28
];

%%%%%%%%%%%%%%%%%%%%%%%%

%x0 = [300,   977,    458.9,   351.97,  175.8,  598.6];

x0 = [255.0,  910.0,  410.0,  300.0,  150.0,  520.0];

lb = [150.0,  700.0,   300.0,   220.0,   100.0,   400.0];

ub = [450.0,  1300.0,  600.0,   480.0,   300.0,   750.0];

options = optimoptions('lsqnonlin', ...
    'Display', 'iter', ...           
    'FiniteDifferenceType', 'forward', ... 
    'FiniteDifferenceStepSize', 1e-4, ... 
    'FunctionTolerance', 1e-7, ...         
    'StepTolerance', 1e-7, ...             
    'OptimalityTolerance', 1e-6, ...       
    'MaxFunctionEvaluations', 3000, ...  
    'MaxIterations', 200);

xfinal = lsqnonlin(@(x) EngineResidual4(x, data), x0, lb, ub, options);

P12= xfinal(1)/10;
T12= xfinal(2)/10;
P26= xfinal(3);
P13= xfinal(4);
P25= xfinal(5)/10;
T34= xfinal(6);

errorP12=((P12-data.P12)/data.P12)*100;
errorT12=((T12-data.T12)/data.T12)*100;
errorP26=((P26-data.P26)/data.P26)*100;
errorP13=((P13-data.P13)/data.P13)*100;
errorP25=((P25-data.P25)/data.P25)*100;
errorT34=((T34-data.T34)/data.T34)*100;

data.P12=P12;
data.T12= T12;
data.P26= P26;
data.P13= P13;
data.P25= P25;
data.T34= T34;

results= ResultsComputation4(data);

errorT25= ((results.T25-data.T25)/data.T25)*100;
errorW25=((results.W25-data.W25)/data.W25)*100;
errorT26= ((results.T26-data.T26)/data.T26)*100;
errorW26=((results.W26-data.W26)/data.W26)*100;
errorP29= ((results.P29-data.P29)/data.P29)*100;
errorT29= ((results.T29-data.T29)/data.T29)*100;
errorW34=((results.W34-data.W34)/data.W34)*100;
errorT10= ((results.T10-data.T10)/data.T10)*100;
errorW10=((results.W10-data.W10)/data.W10)*100;
errorT18= ((results.T18-data.T18)/data.T18)*100;
errorW18=((results.W18-data.W18)/data.W18)*100;
errorT15= ((results.T15-data.T15)/data.T15)*100;
errorW15=((results.W15-data.W15)/data.W15)*100;
errorP19= ((results.P19-data.P19)/data.P19)*100;
errorT19= ((results.T19-data.T19)/data.T19)*100;
errorT40= ((results.T40-data.T40)/data.T40)*100;
errorT41= ((results.T41-data.T41)/data.T41)*100;
errorW41=((results.W41-data.W41)/data.W41)*100;
errorT13= ((results.T13-data.T13)/data.T13)*100;
errorW13=((results.W13-data.W13)/data.W13)*100;
errorT50= ((results.T50-data.T50)/data.T50)*100;
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
errorP17= ((results.P17-data.P17)/data.P17)*100;
errorT17= ((results.T17-data.T17)/data.T17)*100;
errorP28= ((results.P28-data.P28)/data.P28)*100;
errorT28= ((results.T28-data.T28)/data.T28)*100;

RowNames = {
    'P12 [bar]'; 'T12 [K]'; 'P26 [bar]'; 'P13 [bar]'; 'P25 [bar]'; 'T34 [K]'; ...
    'T25 [K]'; 'W25 [MW]'; 'T26 [K]'; 'W26 [MW]'; 'P29 [bar]'; 'T29 [K]'; ...
    'W34 [MW]'; 'T10 [K]'; 'W10 [MW]'; 'T18 [K]'; 'W18 [MW]'; 'T15 [K]'; ...
    'W15 [MW]'; 'P19 [bar]'; 'T19 [K]'; 'T40 [K]'; 'T41 [K]'; 'W41 [MW]'; ...
    'T13 [K]'; 'W13 [MW]'; 'T50 [K]'; 'TS62 [K]'; 'PS63 [bar]'; 'TS63 [K]'; ...
    'vS63 [m/s]'; 'MS63'; 'AS63 [m^2]'; 'P51 [bar]'; 'T51 [K]'; 'v51 [m/s]'; ...
    'M51'; 'A51 [m^2]'; ...
    'P52 [bar]'; 'T52 [K]'; 'v52 [m/s]'; 'M52'; 'A52 [m^2]'; ... % Integrated
    'P53 [bar]'; 'T53 [K]'; 'v53 [m/s]'; 'M53'; 'A53 [m^2]'; ... % Integrated
    'P54 [bar]'; 'T54 [K]'; 'v54 [m/s]'; 'M54'; 'A54 [m^2]'; 'P17 [bar]'; ...
    'T17 [K]'; 'P28 [bar]'; 'T28 [K]'
};

% 
SolvedValues = [
    results.P12; results.T12; results.P26; results.P13; results.P25; results.T34; ...
    results.T25; results.W25; results.T26; results.W26; results.P29; results.T29; ...
    results.W34; results.T10; results.W10; results.T18; results.W18; results.T15; ...
    results.W15; results.P19; results.T19; results.T40; results.T41; results.W41; ...
    results.T13; results.W13; results.T50; results.TS62; results.PS63; results.TS63; ...
    results.vS63; results.MS63; results.AS63; results.P51; results.T51; results.v51; ...
    results.M51; results.A51; ...
    results.P52; results.T52; results.v52; results.M52; results.A52; ... % Integrated
    results.P53; results.T53; results.v53; results.M53; results.A53; ... % Integrated
    results.P54; results.T54; results.v54; results.M54; results.A54; results.P17; ...
    results.T17; results.P28; results.T28
];
% 
BaselineValues = BaselineValues(1:length(SolvedValues));

RelativeErrors_pct = [
    errorP12; errorT12; errorP26; errorP13; errorP25; errorT34; ...
    errorT25; errorW25; errorT26; errorW26; errorP29; errorT29; ...
    errorW34; errorT10; errorW10; errorT18; errorW18; errorT15; ...
    errorW15; errorP19; errorT19; errorT40; errorT41; errorW41; ...
    errorT13; errorW13; errorT50; errorTS62; errorPS63; errorTS63; ...
    errorvS63; errorMS63; errorAS63; errorP51; errorT51; errorv51; ...
    errorM51; errorA51; ...
    errorP52; errorT52; errorv52; errorM52; errorA52; ... % Integrated
    errorP53; errorT53; errorv53; errorM53; errorA53; ... % Integrated
    errorP54; errorT54; errorv54; errorM54; errorA54; errorP17; ...
    errorT17; errorP28; errorT28
];

PerformanceSummaryTable = table(BaselineValues, SolvedValues, RelativeErrors_pct, ...
    'RowNames', RowNames, ...
    'VariableNames', {'Baseline_Reference', 'Solver_Output', 'Relative_Error_Percent'});

fprintf('\n\n=========================================================================\n');
fprintf('                ENGINE SYSTEM MODEL ERROR ASSESSMENT\n');
fprintf('=========================================================================\n\n');
disp(PerformanceSummaryTable);
fprintf('=========================================================================\n');