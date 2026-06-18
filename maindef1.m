clc
clear
close all

%Study on the SE-21D engine

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Input data introduced

%1. Nozzle design conditions (main and secondary) including:
% -Either exit Ae or throat area At [m^2]
% -Expansion ratios epsilon

%2. OF ratio in the combustion chamber (meaning we know the proportionality of moles of 53 & 41

%3. Chamber pressure P60 [bar]

%4. Inlet pressures at the secondary nozzles P16 & P15 [bar]

%5. Tank pressures PLH2 & PLOx [bar]

%6. Efficiencies at the Turbines & Pumps eta10, eta12, eta15, , eta16, eta11

%7. Mechanical efficiencies eta20 & eta21 ?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Unknowns

%Mass flow rate distributions tau30, tau31, tau33

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%There are errors in the diagram, mass flow 45 up until 66 is always 2.649
%kg/s.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Input data

%1.1 Main Nozzle dimension (Dt, De)

data.Dexitmain= 1740.47*1e-3;

data.Dthroatmain= 490.594*1e-3; 

data.epsilonmain= 12.5;

data.etamain= 0.99;

%1.2 Left secondary nozzle dimensions (De, epsilon)

data.Dexitsec1= 189.048*1e-3;

data.epsilonsec1= 1.651;

%1.3 Right secondary nozzle dimensions (De, epsilon) and Input pressures
%(P16, P15)

data.Dexitsec2= 324.415*1e-3;

data.epsilonsec2= 1.657;

%2. OF ratio at combustion chamber

data.OFcc= 456.323/82.968; %Oxidizer fuel at the combustion chamber

%3. Chamber pressure

data.P60= 6.649*10; %bar

%4. Tank pressures (& Temperatures?)

data.PLOX= 0.5*10; %bar

data.TLOX= 90; %K

data.PLH2= 0.3*10; %bar

data.TLH2= 21; %K

data.deltaP43= 8.749/0.3;


%5. Atmospheric Pressure

data.Pa= 0; %bar 

%6. Pressures at the inlets of the seconday nozzles

data.P16= 0.3*10; %bar

data.P15= 0.3*10; %bar

%7. Efficiencies

data.eta11= 0.76;

data.eta10= 0.7;

data.eta12= 0.75;

data.eta15= 0.45;

data.eta16= 0.45;

data.eta66= 0.98;

data.eta68= 0.98;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Reference data

mO2ref = 456.323; 
m53ref= 82.968;
m53Lref= 5.684;
m40ref= 77.283;
PinO2ref = 8.749 * 10; % bar
PinH2ref= 8.312*10;
Poutref = 6.649 * 10; % bar
P22inref= 12.109*10; %bar
T22inref= 32.375; %K
P23outref= 8.749*10; %bar
T23outref= 506.219; %K
P10ref= 8.749*10; %bar
P44ref= 8.311*10; %bar
m23ref= 16.394; 
data.KinjO2 = (PinO2ref - Poutref)/(mO2ref^2);
data.KinjH2= (PinH2ref-Poutref)/(m53ref^2);
data.Kinj40= (P10ref - PinH2ref)/(m40ref^2);
data.Pcc= P22inref/P23outref;
data.deltaP44= P23outref/P44ref;
h22ref = NFP('pH2', 'h_pt', P22inref, T22inref); 
h23ref = NFP('H2', 'h_pt', P23outref, T23outref);
data.Qcc = m23ref*(h23ref - h22ref); %kg/s*kJ/kg -> kJ/s
W16ref= 4.358; %MW
W11ref= 4.315; %MW
data.eta21= W11ref/W16ref;
W10ref= 15.443; %MW
W12ref= 1.01; %MW
W15ref= 16.62; %MW
data.eta20= (W10ref+W12ref)/W15ref;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Unknwons 

m16ref= 2.114;
m15ref= 8.06;
m66ref= 2.649;
m33ref= m15ref+m16ref;
mbleed= 10.709-(m16ref+m15ref);
data.betableed= mbleed/10.704;
data.tau16= m16ref/m33ref;
mLH2ref= 93.677; 
m40ref= 77.283;
m12ref= 16.394; 
data.tau23= m12ref/mLH2ref;
data.tau53L= 0.34672;
data.T11= 92.983;
data.P11= 8.749*10;
data.T53= 62.955;
data.P53= 8.312*10;
data.T60= 3321.91;
data.P64= 0.06*10;
data.Fmain= 2169.459;
data.W11= -4.315;
data.P10= 8.749*10;
data.T10= 29.44;
data.W10= -15.443;
data.P23= 8.749*10;
data.P12= 12.109*10;
data.T12= 32.375;
data.W12= -1.01;
data.T23= 506.219;
data.P44= 8.311*10;
data.T44= 506.452;
data.T15= 369.677;
data.W15= 16.62;
data.T16= 369.677;
data.W16= 4.358;
data.P66= 0.04*10;
data.T66= 230.15;
data.v66= 2240.18;
data.M66= 1.973;
data.P68= 0.04*10;
data.T68= 214.83;
data.v68= 2160.55;
data.M68= 1.975;
data.F66= 6.916;
data.Isp66= 266.22;
data.D66= 189.048;
data.F68= 20.307;
data.Isp68= 259.901;
data.D68= 324.415;
data.deltaPcc= 12.109/8.749;
data.P63= 3.735*10;
data.T63= 3076.08;
data.D63= 490.594;
data.v63= 1516.40;
data.M63= 1;
data.F64= 2169.459;
data.Isp64= 410.212;
data.P64= 0.06*10;
data.T64= 1579;
data.D64= 1740.47;
data.v64= 3799.77;
data.M64= 3.411;
data.m60= 539.29;
data.mLOX= 456.323;

BaselineValues = [
    data.tau23; data.tau53L; data.tau16; data.T11; data.T53; data.P53; data.P11; ...
    data.T60; data.P64; data.W11; data.P10; data.T10; ...
    data.W10; data.P23; data.P12; data.T12; data.W12; ...
    data.T23; data.P44; data.T44; data.T15; data.W15; ...
    data.P16; data.T16; data.W16; data.P66; data.T66; ...
    data.v66; data.M66; data.F66; data.Isp66; data.D66; ...
    data.P68; data.T68; data.v68; data.M68; data.F68; ...
    data.Isp68; data.D68; data.P63; data.T63; data.v63; ...
    data.M63; data.D63; data.T64; data.v64; data.M64; ...
    data.F64; data.Isp64; data.D64
];

%x0= [0.1750, 0.3467, 0.2078, 0.92983, 0.62955, 0.8312, 0.8749]; %The results that are intended to be obtained

x0 = [0.25, 0.20, 0.4, 0.8, 0.7, 0.78, 0.75];


options = optimoptions('lsqnonlin', ...
    'Display', 'iter', ...           
    'FiniteDifferenceType', 'forward', ... 
    'FiniteDifferenceStepSize', 1e-4, ...  
    'FunctionTolerance', 1e-7, ...         
    'StepTolerance', 1e-7, ...             
    'OptimalityTolerance', 1e-6, ...       
    'MaxFunctionEvaluations', 3000, ...  
    'MaxIterations', 200);

lb = [0.01, 0.01, 0.01,  0.2,  0.2,  0.100,  0.100]; % Pressures can't go below chamber pressure
ub = [0.99, 0.99, 0.99,  0.99,  0.99,  0.99,  0.99]; 
xfinal = lsqnonlin(@(x) EngineResidual(x, data), x0, lb, ub, options);

tau23= xfinal(1);
tau53L= xfinal(2);
tau16= xfinal(3);
T11= xfinal(4)*100;
T53= xfinal(5)*100;
P53= xfinal(6)*100;
P11= xfinal(7)*100;

errortau23= ((tau23-data.tau23)/data.tau23)*100;
errortau53L= ((tau53L-data.tau53L)/data.tau53L)*100;
errortau16= ((tau16-data.tau16)/data.tau16)*100;
errorT11= ((T11-data.T11)/data.T11)*100;
errorT53= ((T53-data.T53)/data.T53)*100;
errorP53= ((P53-data.P53)/data.P53)*100;
errorP11= ((P11-data.P11)/data.P11)*100;

data.tau23 = tau23;
data.tau53L = tau53L;
data.tau16 = tau16;
data.T11= T11;
data.T53= T53;
data.P53= P53;
data.P11= P11;

results= ResultsComputation(data);


errorT60=((results.T60-data.T60)/data.T60)*100;
errorP64=((results.P64-data.P64)/data.P64)*100;
errorW11=((results.W11-data.W11)/data.W11)*100;
errorP10=((results.P10-data.P10)/data.P10)*100;
errorT10=((results.T10-data.T10)/data.T10)*100;
errorW10=((results.W10-data.W10)/data.W10)*100;
errorP23=((results.P23-data.P23)/data.P23)*100;
errorP12=((results.P12-data.P12)/data.P12)*100;
errorT12=((results.T12-data.T12)/data.T12)*100;
errorW12=((results.W12-data.W12)/data.W12)*100;
errorT23=((results.T23-data.T23)/data.T23)*100;
errorP44=((results.P44-data.P44)/data.P44)*100;
errorT44=((results.T44-data.T44)/data.T44)*100;
errorT15=((results.T15-data.T15)/data.T15)*100;
errorW15=((results.W15-data.W15)/data.W15)*100;
errorP16=((results.P16-data.P16)/data.P16)*100;
errorT16=((results.T16-data.T16)/data.T16)*100;
errorW16=((results.W16-data.W16)/data.W16)*100;
errorP66=((results.P66-data.P66)/data.P66)*100;
errorT66=((results.T66-data.T66)/data.T66)*100;
errorv66=((results.v66-data.v66)/data.v66)*100;
errorM66=((results.M66-data.M66)/data.M66)*100;
errorF66=((results.F66-data.F66)/data.F66)*100;
errorIsp66=((results.Isp66-data.Isp66)/data.Isp66)*100;
errorP68=((results.P68-data.P68)/data.P68)*100;
errorT68=((results.T68-data.T68)/data.T68)*100;
errorv68=((results.v68-data.v68)/data.v68)*100;
errorM68=((results.M68-data.M68)/data.M68)*100;
errorF68=((results.F68-data.F68)/data.F68)*100;
errorIsp68=((results.Isp68-data.Isp68)/data.Isp68)*100;
errorP63=((results.P63-data.P63)/data.P63)*100;
errorT63=((results.T63-data.T63)/data.T63)*100;
errorv63=((results.v63-data.v63)/data.v63)*100;
errorM63=((results.M63-data.M63)/data.M63)*100;
errorD63=((results.D63-data.D63)/data.D63)*100;
errorT64=((results.T64-data.T64)/data.T64)*100;
errorv64=((results.v64-data.v64)/data.v64)*100;
errorM64=((results.M64-data.M64)/data.M64)*100;
errorF64=((results.F64-data.F64)/data.F64)*100;
errorIsp64=((results.Isp64-data.Isp64)/data.Isp64)*100;
errorD64=((results.D64-data.D64)/data.D64)*100;
errorD66=((results.D66-data.D66)/data.D66)*100;
errorD68=((results.D68-data.D68)/data.D68)*100;

RowNames = {
    'tau23'; 'tau53L'; 'tau16'; 'T11 [K]'; 'T53 [K]'; 'P53 [bar]'; 'P11 [bar]'; ...
    'T60 [K]'; 'P64 [bar]'; 'W11 [MW]'; 'P10 [bar]'; 'T10 [K]'; ...
    'W10 [MW]'; 'P23 [bar]'; 'P12 [bar]'; 'T12 [K]'; 'W12 [MW]'; ...
    'T23 [K]'; 'P44 [bar]'; 'T44 [K]'; 'T15 [K]'; 'W15 [MW]'; ...
    'P16 [bar]'; 'T16 [K]'; 'W16 [MW]'; 'P66 [bar]'; 'T66 [K]'; ...
    'v66 [m/s]'; 'M66'; 'F66 [kN]'; 'Isp66 [s]'; 'D66 [mm]'; ...
    'P68 [bar]'; 'T68 [K]'; 'v68 [m/s]'; 'M68'; 'F68 [kN]'; ...
    'Isp68 [s]'; 'D68 [mm]'; 'P63 [bar]'; 'T63 [K]'; 'v63 [m/s]'; ...
    'M63'; 'D63 [mm]'; 'T64 [K]'; 'v64 [m/s]'; 'M64'; ...
    'F64 [kN]'; 'Isp64 [s]'; 'D64 [mm]'
};

SolvedValues = [
    tau23; tau53L; tau16; T11; T53; P53; P11; ...
    results.T60; results.P64; results.W11; results.P10; results.T10; ...
    results.W10; results.P23; results.P12; results.T12; results.W12; ...
    results.T23; results.P44; results.T44; results.T15; results.W15; ...
    results.P16; results.T16; results.W16; results.P66; results.T66; ...
    results.v66; results.M66; results.F66; results.Isp66; results.D66; ...
    results.P68; results.T68; results.v68; results.M68; results.F68; ...
    results.Isp68; results.D68; results.P63; results.T63; results.v63; ...
    results.M63; results.D63; results.T64; results.v64; results.M64; ...
    results.F64; results.Isp64; results.D64
];

RelativeErrors_pct = [
    errortau23; errortau53L; errortau16; errorT11; errorT53; errorP53; errorP11; ...
    errorT60; errorP64; errorW11; errorP10; errorT10; ...
    errorW10; errorP23; errorP12; errorT12; errorW12; ...
    errorT23; errorP44; errorT44; errorT15; errorW15; ...
    errorP16; errorT16; errorW16; errorP66; errorT66; ...
    errorv66; errorM66; errorF66; errorIsp66; errorD66; ...
    errorP68; errorT68; errorv68; errorM68; errorF68; ...
    errorIsp68; errorD68; errorP63; errorT63; errorv63; ...
    errorM63; errorD63; errorT64; errorv64; errorM64; ...
    errorF64; errorIsp64; errorD64
];

PerformanceSummaryTable = table(BaselineValues, SolvedValues, RelativeErrors_pct, ...
    'RowNames', RowNames, ...
    'VariableNames', {'Baseline_Reference', 'Solver_Output', 'Relative_Error_Percent'});

fprintf('\n\n=========================================================================\n');
fprintf('                SE-21D ENGINE SYSTEM MODEL ERROR ASSESSMENT\n');
fprintf('=========================================================================\n\n');
disp(PerformanceSummaryTable);
fprintf('=========================================================================\n');