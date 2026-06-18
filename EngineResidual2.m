function error= EngineResidual2(x, data)


P34= x(1);
T34= x(2);
P13= x(3);
T13= x(4);
P37= x(5);
T37= x(6);
P25= x(7)/10;
P10= x(8)/10;


PH2= data.PH2;
TH2= data.TH2;
PO2= data.PO2;
TO2= data.TO2;
deltaP59= data.deltaP59;
deltaP76= data.deltaP76;
deltaP58= data.deltaP58;
deltaP31= data.deltaP31;
deltaP38=data.deltaP38;
deltaP21=data.deltaP21;
deltaP62=data.deltaP62;
eta18= data.eta18;
deltaP61= data.deltaP61;
deltaP20= data.deltaP20;
etacstar= data.etacstar;
eta46= data.eta46;
deltaP47= data.deltaP47;
deltaP63= data.deltaP63;
deltaP17= data.deltaP17;
deltaP68= data.deltaP68;
eta41= data.eta41;
deltaP42= data.deltaP42;
eta10= data.eta10;
eta15= data.eta15;
eta13= data.eta13;
deltaP67= data.deltaP67;
deltaP70= data.deltaP70;
deltaP36= data.deltaP36;
deltaP64= data.deltaP64;
deltaP32= data.deltaP32;
eta34= data.eta34;
eta26= data.eta26;
Q32= data.Q32;
deltaP73= data.deltaP73;
Q28= data.Q28;

deltaP28= data.deltaP28;

eta95= data.eta95;
eta90= data.eta90;
eta96= data.eta96;
eta92= data.eta92;

eta25= data.eta25;

Q68= data.Q68;

tau73= data.tau73;
tau59= data.tau59;
tau58= data.tau58;
tau38= data.tau38;
tau32= data.tau32;
tau36= data.tau36;
tau15= data.tau15;
tau67= data.tau67;
tau18= data.tau18;
tau61= data.tau61;

D51= data.D51;

P4P1= data.P4P1;

etaSQT= data.etaSQT;

OF= data.OF;

species = {'H2', 'O2', 'H2O', 'H', 'O', 'OH'};

mtotal=1000; %First, 1000 kg of total mass flow is considered only

mH2= mtotal/(OF+1);
mO2= (OF*mtotal)/(OF+1);

m32= mH2*tau32;
m35= mH2*(1-tau32);
m36= m35*tau36;
m28= m35*(1-tau36);
m37= m35;
m73= m32*tau73;
m72= m32*(1-tau73);
m59= m72*tau59;
m74= m72*(1-tau59);
m58= m74*tau58;
m76= m74*(1-tau58);
m38= m37*tau38;
m31= m37*(1-tau38);

%System of equations
% m12= m15+mO2;
% m66= m12*(1-tau15);
% m15= tau15*m12;

%It is found that m66=mO2, verified in the diagram as well. Thus, the
%following expressions are found:

m66= mO2;
m12=  mO2/(1-tau15);
m15= (tau15*mO2)/(1-tau15);

%We continue with the rest
m67= tau67*m66;
m16= (1-tau67)*m66;
m18= m16*tau18;
m63= m16*(1-tau18);
m61= tau61*m18;
m62= (1-tau61)*m18;
m40= m38+m61;
m45= m62+m31;

m48= m58+m40;
m49= m45+m59;

[P59, T59]= valve(P34, T34, deltaP59, 'pH2');

[P76, T76]= valve(P34, T34, deltaP76, 'pH2');

[P58, T58]= valve(P34, T34, deltaP58, 'pH2');

[P31, T31]= valve(P37, T37, deltaP31, 'pH2');

[P38, T38]= valve(P37, T37, deltaP38, 'pH2');

P21= P31;

P62= P21*deltaP21;

P18= P62*deltaP62;

[P63, T63]= valve(P13, T13, deltaP63, 'O2');

[T18, W18]= compressor(P13, T13, P18, eta18, 'O2', m18);

[P61, T61]= valve(P18, T18, deltaP61, 'O2');

[P20, T20]= valve(P61, T61, deltaP20, 'O2');

[~, T62]= valve(P18, T18, deltaP62, 'O2');

[~, T21]= valve(P62, T62, deltaP21, 'O2');

P45= P21;

MWH2 = NFP('pH2', 'MM'); 
MWO2 = NFP('O2', 'MM');

n31 = m31/MWH2; 
n21 = m62/MWO2;

[T45, n45]= combustionchamber(species, 'pH2', 'O2', n31, n21, P31, T31, P21, T21, P45, etacstar);

P46= P59;

[T46, W46]= turbine_mixture(species, n45, P45, T45, P46, eta46);

n59= [m59/NFP('pH2', 'MM'); 0; 0; 0; 0; 0];

P49= P46;

[T49, n49]= combustionchambermixture(species, n59, 'pH2', P59, T59, n45, P46, T46, P49, 1);

[P47, T47] = valve_mixture(species, n49, P49, T49, deltaP47);


[P17, T17]= valve(P63, T63, deltaP17, 'O2');

MWH2 = NFP('pH2', 'MM'); 
MWO2 = NFP('O2', 'MM');

n38 = m38 / MWH2; 
n61 = m61 / MWO2;

P40= P38;

[T40, n40]= combustionchamber(species, 'pH2', 'O2', n38, n61, P38, T38, P20, T20, P40, etacstar);

P68= P58;

P41= P68*deltaP68;

[T41,W41]= turbine_mixture(species, n40, P40, T40, P41, eta41);

H41= HGSprop(species, n40, T41, P41, 'H');

H68= H41-Q68;

options = optimoptions('fsolve', ...
                         'Algorithm', 'levenberg-marquardt', ...
                         'FunctionTolerance', 1e-6, ...   % Relaxed slightly
                         'StepTolerance', 1e-6, ...       % Loosened to prevent stalling
                         'Display', 'off');

T68= HGStp(species, n40, 'H', H68, P68);

n58= [m58/(NFP('pH2', 'MM')); 0; 0; 0; 0; 0];

n68= n40;

P48= P68;

[T48, n48]= combustionchambermixture(species, n58, 'pH2', P58, T58, n68, P68, T68, P48, 1);

[P42, T42] = valve_mixture(species, n48, P48, T48, deltaP42);

P50= P47;

n63= [0; m63/NFP('O2', 'MM'); 0; 0; 0; 0];

n76= [m76/NFP('pH2', 'MM'); 0; 0; 0; 0; 0];

[T50, n50] = combustionchamber4flows(species, n49, P47, T47, n48, P42, T42, n63, 'O2', P17, T17, n76, 'pH2', P76, T76, P50, etaSQT);

PS62= P50*P4P1;

H50 = HGSprop(species, n50, T50, P50, 'H');

HS62= H50;

[TS62, ~, nS62, ~] = HGStp(species, n50, 'H', HS62, PS62);

[m50, ~, ~]= Nozzleflow(species, nS62, TS62, PS62, D51); %D51= Dthroat

nS62= nS62*m50/mtotal;

mtotal= m50;

m18old= m18;
m45old= m45;
m40old= m40;

mH2= mtotal/(OF+1);
mO2= (OF*mtotal)/(OF+1);
m32= mH2*tau32;
m35= mH2*(1-tau32);
m36= m35*tau36;
m28= m35*(1-tau36);
m37= m35;
m73= m32*tau73;
m72= m32*(1-tau73);
m59= m72*tau59;
m74= m72*(1-tau59);
m58= m74*tau58;
m76= m74*(1-tau58);
m38= m37*tau38;
m31= m37*(1-tau38);
m66= mO2;
m12=  mO2/(1-tau15);
m15= (tau15*mO2)/(1-tau15);
m67= tau67*m66;
m16= (1-tau67)*m66;
m18= m16*tau18;
m63= m16*(1-tau18);
m61= tau61*m18;
m62= (1-tau61)*m18;
m40= m38+m61;
m45= m62+m31;
m48= m58+m40;
m49= m45+m59;

W18= W18*m18/m18old;

W46= W46*m45/m45old;

W41= W41*m40/m40old;

[T10, W10]= compressor(PO2, TO2, P10, eta10, 'O2', mO2);

P15= P10;

[T15, W15]= turbine(P13, T13, P15, eta15, 'O2', m15);

h10= NFP('O2', 'h_pt', P10, T10);

h15= NFP('O2', 'h_pt', P10, T15);

h12= ((mO2*h10)+(m15*h15))/m12;

P12= P10;

T12= NFP('O2', 't_hp', h12, P12);

[T13computed, W13]= compressor(P12, T12, P13, eta13, 'O2', m12);

P67= P13/deltaP67;

H13= NFP('O2', 'h_pt', P13, T13);

H67= H13+(Q68/m67);

T67= NFP('O2', 't_hp', H67, P67);

[P70, T70] = valve(P67, T67, deltaP70, 'O2');

[T25, W25]= compressor(PH2, TH2, P25, eta25, 'pH2', mH2);

P36= P37;

P64= P36*deltaP36;

P26= P64*deltaP64;

[T26, W26]= compressor(P25, T25, P26, eta26, 'pH2', mH2);

[~, T64]= valve(P26, T26,deltaP64, 'pH2');

H64= NFP('pH2', 'h_pt', P64, T64);

H32= H64+(Q32/(m32));

P32= P64/deltaP32;

T32= NFP('pH2', 't_hp', H32, P32);

[T34computed, W34]= turbine(P32, T32, P34, eta34, 'pH2', m32);

[P73, T73]= valve(P34, T34, deltaP73, 'pH2');

[~, T36]= valve(P64, T64, deltaP36, 'pH2');

H28= H64+(Q28/m28);

P28= P64/deltaP28;

T28= NFP('pH2', 't_hp', H28, P28);

h36= NFP('pH2', 'h_pt', P36, T36);

h28= NFP('pH2', 'h_pt', P28, T28);

m37= m36+m28;

h37= ((m36*h36)+(m28*h28))/m37;

P37= P36;

T37computed= NFP('pH2', 't_hp', h37, P37);


rho73 = NFP('pH2', 'r_pt', P73, T73); 
V73   = m73 / rho73;

rhoH2 = NFP('pH2', 'r_pt', PH2, TH2); 
VH2   = mH2 / rhoH2;

rho70 = NFP('O2', 'r_pt', P70, T70);   
V70   = m67 / rho70;

rhoO2 = NFP('O2', 'r_pt', PO2, TO2);   
VO2   = mO2 / rhoO2;


error(1)= (W25+(eta95*W34))/abs(W25);
error(2)= (W10+(eta90*W15))/abs(W10);
error(3)= (W26+(eta96*W46))/abs(W26);
error(4)= ((W18+W13)+(eta92*W41))/abs(W18+W13);
error(5)= (T34-T34computed)/T34;
error(6)= (T37-T37computed)/T37;
error(7)= (T13-T13computed)/T13;
error(8)= (V73-VH2)/VH2;
error(9)= (V70-VO2)/VO2;


end