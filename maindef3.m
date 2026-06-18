clc
clear
close all

%SE-12 engine

data.PCH4= 0.3*10; %bar
data.TCH4= 110; %K

data.P13= 1.2*10; %bar
data.T13= 110.432; %K
data.eta13= 0.8;
data.W13= -0.695; %MW


data.PLOX= 0.5*10;
data.TLOX= 90;
data.mLOX= 951.329;

data.Pa=0;

data.P16= 1.224*10;
data.T16= 127.89;
data.eta16= 0.7;
data.W16= 0.699;

data.eta24= 0.695/0.699;
data.eta20= (36.016+2.069+67.114)/105.728;
data.eta25= 0.728/0.732;


data.mCH4= 264.258;
data.m16= 9.334;
data.m53= 273.593;

data.P10= 46.648*10;
data.eta10= 0.8;
data.T10= 131.475;
data.W10= -36.016;

data.deltaP72= 46.648/46.181;

data.deltaP48= 90.087/66.034;
data.P48= 66.034*10;
data.T48= 162.691; %K

data.m72= 16.318;
data.P72= 46.181*10;
data.T72= 131.7; %K

data.P12= 90.087*10;
data.T12=149.97;
data.W12= -2.069;
data.eta12= 0.8;

data.tau26= 2.837/970.484;
data.tau16= 9.334/273.593;
data.tau72= 16.318/(16.318+247.935);

data.deltaP43= 1.224/1.2;


data.P52= 59.761*10;
data.T52= 775.915; 

data.P49= 66.034*10;
data.T49= 111.73;

data.P15= 28.093*10;
data.T15= 675.237; %K
data.W15= 105.728;
data.eta15= 0.78;

data.deltaP41= (1.377+26.155)/26.981;
data.P41= 26.981*10;
data.T41= 675.237;

data.deltaP42= 28.093/(1.377+26.155);

data.Q26= 0.2e3; %kW
data.deltaP26= (26.155+1.377)/26.155;
data.P26= 26.155*10;
data.T26= 608.585;

data.P17= 1.224*10;
data.T17= 352.327;
data.eta17= 0.7;
data.W17= 0.732; %MW

data.deltaP44= 1.224/1.2;

data.P11= 67.382*10;
data.T11= 111.208;
data.eta11= 0.8;
data.W11= -67.114;

data.deltaP49= 67.382/66.034;
data.P49= 66.034*10;
data.T49= 111.73; %K

data.P40= 26.981*10;
data.T40= 202.974;

data.P14= 1.2*10;
data.T14= 90.231; 
data.W14= -0.728; %MW
data.eta14= 0.8;

data.m26= 2.837; 

data.P60= 25.632*10;
data.T60= 3586.694;


data.P63= 14.841*10;
data.T63= 3394.916; %K
data.D63= 328.086; %mm
data.v63= 1167.733; %m/s
data.M63= 1;

data.F64= 4152; %kN
data.Isp64= 348.305; %s
data.epsilon= 36.4;
data.P64= 0.071*10;
data.T64= 1745.856; %K
data.D64= 1981.104; %mm
data.v64= 3288.216; %m/s
data.M64= 3.916;

P41ref= 26.981*10;
P60ref= 25.632*10;
m41ref= 967.628;
data.KinjO2 = (P41ref-P60ref)/(m41ref^2);

P22inref= 46.648*10;
T22inref= 131.475;

P40ref= 26.981*10;
T40ref= 202.974; %K
m23ref= 247.935; %kg/s

h22ref = NFP('CH4', 'h_pt', P22inref, T22inref); 
h40ref = NFP('CH4', 'h_pt', P40ref, T40ref);
data.Qcc = m23ref*(h40ref - h22ref);
data.deltaPcc= 46.648/26.981;

data.etanozzle= 0.985;

data.OF= 3.6;

BaselineValues = [
    data.P10; data.T10; data.P11; data.T11; data.T40; data.P14; data.P13; ...
    data.T13; data.W13; data.T14; data.W14; data.W10; data.T16; data.W16; ...
    data.P72; data.T72; data.T12; data.W12; data.P48; data.T48; data.P49; ...
    data.T49; data.T52; data.T15; data.W15; data.P40; data.P41; data.T41; ...
    data.T60; data.P26; data.T26; data.T17; data.W17; data.W11; data.P63; ...
    data.T63; data.v63; data.M63; data.D63; data.P64; data.T64; data.v64; ...
    data.M64; data.F64; data.Isp64; data.D64; ...
    data.P12; data.P15; data.P16; data.P17  
];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%x0 = [466.48,  131.475,  673.82,   111.208,  202.974,  120,  120];

x0 = [420.0,   120.0,    620.0,   100.0,    180.0,    90,   105];

lb = [350.0,   100.0,    500.0,   95.0,     150.0,    80,    80];

ub = [550.0,   170.0,    700.0,   140.0,    300.0,    200,   200];

options = optimoptions('lsqnonlin', ...
    'Display', 'iter', ...           
    'FiniteDifferenceType', 'forward', ... 
    'FiniteDifferenceStepSize', 1e-4, ...  
    'FunctionTolerance', 1e-7, ...         
    'StepTolerance', 1e-7, ...             
    'OptimalityTolerance', 1e-6, ...       
    'MaxFunctionEvaluations', 3000, ...  
    'MaxIterations', 200);

xfinal = lsqnonlin(@(x) EngineResidual3(x, data), x0, lb, ub, options);

P10=xfinal(1);
T10= xfinal(2);
P11= xfinal(3);
T11= xfinal(4);
T40= xfinal(5);
P14= xfinal(6)/10;
P13= xfinal(7)/10;

errorP10=((P10-data.P10)/data.P10)*100;
errorT10=((T10-data.T10)/data.T10)*100;
errorP11=((P11-data.P11)/data.P11)*100;
errorT11=((T11-data.T11)/data.T11)*100;
errorT40=((T40-data.T40)/data.T40)*100;
errorP14=((P14-data.P14)/data.P14)*100;
errorP13=((P13-data.P13)/data.P13)*100;

data.P10=P10;
data.T10= T10;
data.P11= P11;
data.T11= T11;
data.T40= T40;
data.P14= P14;
data.P13= P13;

results= ResultsComputation3(data);

errorT13=((results.T13-data.T13)/data.T13)*100;
errorW13=((results.W13-data.W13)/data.W13)*100;
errorT14=((results.T14-data.T14)/data.T14)*100;
errorW14=((results.W14-data.W14)/data.W14)*100;
errorW10=((results.W10-data.W10)/data.W10)*100;
errorT16=((results.T16-data.T16)/data.T16)*100;
errorW16=((results.W16-data.W16)/data.W16)*100;
errorP72=((results.P72-data.P72)/data.P72)*100;
errorT72=((results.T72-data.T72)/data.T72)*100;
errorT12=((results.T12-data.T12)/data.T12)*100;
errorW12=((results.W12-data.W12)/data.W12)*100;
errorP48=((results.P48-data.P48)/data.P48)*100;
errorT48=((results.T48-data.T48)/data.T48)*100;
errorP49=((results.P49-data.P49)/data.P49)*100;
errorT49=((results.T49-data.T49)/data.T49)*100;
errorT52=((results.T52-data.T52)/data.T52)*100;
errorT15=((results.T15-data.T15)/data.T15)*100;
errorW15=((results.W15-data.W15)/data.W15)*100;
errorP40=((results.P40-data.P40)/data.P40)*100;
errorP41=((results.P41-data.P41)/data.P41)*100;
errorT41=((results.T41-data.T41)/data.T41)*100;
errorT60=((results.T60-data.T60)/data.T60)*100;
errorP26=((results.P26-data.P26)/data.P26)*100;
errorT26=((results.T26-data.T26)/data.T26)*100;
errorT17=((results.T17-data.T17)/data.T17)*100;
errorW17=((results.W17-data.W17)/data.W17)*100;
errorW11=((results.W11-data.W11)/data.W11)*100;
errorP63=((results.P63-data.P63)/data.P63)*100;
errorT63=((results.T63-data.T63)/data.T63)*100;
errorv63=((results.v63-data.v63)/data.v63)*100;
errorM63=((results.M63-data.M63)/data.M63)*100;
errorD63=((results.D63-data.D63)/data.D63)*100;
errorP64=((results.P64-data.P64)/data.P64)*100;
errorT64=((results.T64-data.T64)/data.T64)*100;
errorv64=((results.v64-data.v64)/data.v64)*100;
errorM64=((results.M64-data.M64)/data.M64)*100;
errorF64=((results.F64-data.F64)/data.F64)*100;
errorIsp64=((results.Isp64-data.Isp64)/data.Isp64)*100;
errorD64=((results.D64-data.D64)/data.D64)*100;
errorP12=((results.P12-data.P12)/data.P12)*100;
errorP15=((results.P15-data.P15)/data.P15)*100;
errorP16=((results.P16-data.P16)/data.P16)*100;
errorP17=((results.P17-data.P17)/data.P17)*100;

RowNames = {
    'P10 [bar]'; 'T10 [K]'; 'P11 [bar]'; 'T11 [K]'; 'T40 [K]'; 'P14 [bar]'; 'P13 [bar]'; ...
    'T13 [K]'; 'W13 [MW]'; 'T14 [K]'; 'W14 [MW]'; 'W10 [MW]'; 'T16 [K]'; 'W16 [MW]'; ...
    'P72 [bar]'; 'T72 [K]'; 'T12 [K]'; 'W12 [MW]'; 'P48 [bar]'; 'T48 [K]'; 'P49 [bar]'; ...
    'T49 [K]'; 'T52 [K]'; 'T15 [K]'; 'W15 [MW]'; 'P40 [bar]'; 'P41 [bar]'; 'T41 [K]'; ...
    'T60 [K]'; 'P26 [bar]'; 'T26 [K]'; 'T17 [K]'; 'W17 [MW]'; 'W11 [MW]'; 'P63 [bar]'; ...
    'T63 [K]'; 'v63 [m/s]'; 'M63'; 'D63 [mm]'; 'P64 [bar]'; 'T64 [K]'; 'v64 [m/s]'; ...
    'M64'; 'F64 [kN]'; 'Isp64 [s]'; 'D64 [mm]'; ...
    'P12 [bar]'; 'P15 [bar]'; 'P16 [bar]'; 'P17 [bar]' 
};

% Extract Solved Values Matrix
SolvedValues = [
    results.P10; results.T10; results.P11; results.T11; results.T40; results.P14; results.P13; ...
    results.T13; results.W13; results.T14; results.W14; results.W10; results.T16; results.W16; ...
    results.P72; results.T72; results.T12; results.W12; results.P48; results.T48; results.P49; ...
    results.T49; results.T52; results.T15; results.W15; results.P40; results.P41; results.T41; ...
    results.T60; results.P26; results.T26; results.T17; results.W17; results.W11; results.P63; ...
    results.T63; results.v63; results.M63; results.D63; results.P64; results.T64; results.v64; ...
    results.M64; results.F64; results.Isp64; results.D64; ...
    results.P12; results.P15; results.P16; results.P17
];

BaselineValues = BaselineValues(1:length(SolvedValues));


% Extract Relative Percent Errors Matrix
RelativeErrors_pct = [
    errorP10; errorT10; errorP11; errorT11; errorT40; errorP14; errorP13; ...
    errorT13; errorW13; errorT14; errorW14; errorW10; errorT16; errorW16; ...
    errorP72; errorT72; errorT12; errorW12; errorP48; errorT48; errorP49; ...
    errorT49; errorT52; errorT15; errorW15; errorP40; errorP41; errorT41; ...
    errorT60; errorP26; errorT26; errorT17; errorW17; errorW11; errorP63; ...
    errorT63; errorv63; errorM63; errorD63; errorP64; errorT64; errorv64; ...
    errorM64; errorF64; errorIsp64; errorD64; ...
    errorP12; errorP15; errorP16; errorP17
];

% Construct Performance Summary Table
PerformanceSummaryTable = table(BaselineValues, SolvedValues, RelativeErrors_pct, ...
    'RowNames', RowNames, ...
    'VariableNames', {'Baseline_Reference', 'Solver_Output', 'Relative_Error_Percent'});

% Print Assessment Report
fprintf('\n\n=========================================================================\n');
fprintf('                ENGINE SYSTEM MODEL ERROR ASSESSMENT\n');
fprintf('=========================================================================\n\n');
disp(PerformanceSummaryTable);
fprintf('=========================================================================\n');