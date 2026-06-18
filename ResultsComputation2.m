function results= ResultsComputation2(data)

P34= data.P34;
T34= data.T34;
P13= data.P13;
T13= data.T13;
P37= data.P37;
T37= data.T37;
P25= data.P25;
P10= data.P10;


PH2= data.PH2;
TH2= data.TH2;
PO2= data.PO2;
TO2= data.TO2;
deltaP59= data.deltaP59;
deltaP76= data.deltaP76;
deltaP58= data.deltaP58;
deltaP63= data.deltaP63;
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
Pa= data.Pa;
P54= data.P54;

deltaP28= data.deltaP28;


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
epsilon= data.epsilon;

DS63= data.DS63;
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

results.P18= P18;

results.T18= T18;

[P61, T61]= valve(P18, T18, deltaP61, 'O2');

[P20, T20]= valve(P61, T61, deltaP20, 'O2');

[~, T62]= valve(P18, T18, deltaP62, 'O2');

[~, T21]= valve(P62, T62, deltaP21, 'O2');

P45= P21;

results.P45= P45;

MWH2 = NFP('pH2', 'MM'); 
MWO2 = NFP('O2', 'MM');

n31 = m31/MWH2; 
n21 = m62/MWO2;

[T45, n45]= combustionchamber(species, 'pH2', 'O2', n31, n21, P31, T31, P21, T21, P45, etacstar);

results.T45= T45;

P46= P59;

results.P46= P46;

[T46, W46]= turbine_mixture(species, n45, P45, T45, P46, eta46);

results.T46= T46;

n59= [m59/NFP('pH2', 'MM'); 0; 0; 0; 0; 0];

P49= P46;

results.P49= P49;

[T49, n49]= combustionchambermixture(species, n59, 'pH2', P59, T59, n45, P46, T46, P49, 1);

results.T49= T49;

[P47, T47] = valve_mixture(species, n49, P49, T49, deltaP47);


[P17, T17]= valve(P63, T63, deltaP17, 'O2');

MWH2 = NFP('pH2', 'MM'); 
MWO2 = NFP('O2', 'MM');

n38 = m38 / MWH2; 
n61 = m61 / MWO2;

P40= P38;

results.P40= P40;

[T40, n40]= combustionchamber(species, 'pH2', 'O2', n38, n61, P38, T38, P20, T20, P40, etacstar);

results.T40= T40;

P68= P58;

results.P68= P68;

P41= P68*deltaP68;

[T41, W41]= turbine_mixture(species, n40, P40, T40, P41, eta41);

results.P41= P41;

results.T41= T41;

H41= HGSprop(species, n40, T41, P41, 'H');

H68= H41-Q68;

T68= HGStp(species, n40, 'H', H68, P68);

results.T68= T68;

n58= [m58/(NFP('pH2', 'MM')); 0; 0; 0; 0; 0];

n68= n40;

P48= P68;

results.P48= P48;

[T48, n48]= combustionchambermixture(species, n58, 'pH2', P58, T58, n68, P68, T68, P48, 1);

results.T48= T48;

[P42, T42] = valve_mixture(species, n48, P48, T48, deltaP42);

P50= P47;

results.P50= P50;

n63= [0; m63/NFP('O2', 'MM'); 0; 0; 0; 0];

n76= [m76/NFP('pH2', 'MM'); 0; 0; 0; 0; 0];

[T50, n50] = combustionchamber4flows(species, n49, P47, T47, n48, P42, T42, n63, 'O2', P17, T17, n76, 'pH2', P76, T76, P50, etaSQT);

results.T50= T50;

PS62= P50*P4P1;

H50 = HGSprop(species, n50, T50, P50, 'H');

HS62= H50;

[TS62, ~, nS62, ~] = HGStp(species, n50, 'H', HS62, PS62);

results.PS62= PS62;

results.TS62= TS62;

[m50, ~, ~]= Nozzleflow(species, nS62, TS62, PS62, D51); %D51= Dthroat

nS62= nS62*m50/mtotal;

results.m50= m50;

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

results.W18= W18;

results.W46= W46;

results.W41= W41;

[T10, W10]= compressor(PO2, TO2, P10, eta10, 'O2', mO2);

results.T10= T10; 

results.W10= W10;

P15= P10;

[T15, W15]= turbine(P13, T13, P15, eta15, 'O2', m15);

results.T15= T15; 

results.W15= W15;

h10= NFP('O2', 'h_pt', P10, T10);

h15= NFP('O2', 'h_pt', P10, T15);

h12= ((mO2*h10)+(m15*h15))/m12;

P12= P10;

T12= NFP('O2', 't_hp', h12, P12);

results.P12= P12;

results.T12= T12;

[T13computed, W13]= compressor(P12, T12, P13, eta13, 'O2', m12);

results.W13= W13;

P67= P13/deltaP67;

results.P67= P67;

H13= NFP('O2', 'h_pt', P13, T13);

H67= H13+(Q68/m67);

T67= NFP('O2', 't_hp', H67, P67);

results.T67= T67;

[P70, T70] = valve(P67, T67, deltaP70, 'O2');

results.P70= P70;

results.T70= T70;

[T25, W25]= compressor(PH2, TH2, P25, eta25, 'pH2', mH2);

results.T25= T25;

results.W25= W25;

P36= P37;

P64= P36*deltaP36;

P26= P64*deltaP64;

[T26, W26]= compressor(P25, T25, P26, eta26, 'pH2', mH2);

results.P26= P26; 

results.T26= T26;

results.W26= W26;

[~, T64]= valve(P26, T26,deltaP64, 'pH2');

results.P64= P64;

results.T64= T64;

H64= NFP('pH2', 'h_pt', P64, T64);

H32= H64+(Q32/(m32));

P32= P64/deltaP32;

results.P32= P32;

T32= NFP('pH2', 't_hp', H32, P32);

results.T32= T32;

[T34computed, W34]= turbine(P32, T32, P34, eta34, 'pH2', m32);

results.T34= T34;

results.W34= W34;

[P73, T73]= valve(P34, T34, deltaP73, 'pH2');

results.P73= P73;

results.T73= T73;

[~, T36]= valve(P64, T64, deltaP36, 'pH2');

results.P36= P36;

results.T36= T36;

H28= H64+(Q28/m28);

P28= P64/deltaP28;

results.P28= P28;

T28= NFP('pH2', 't_hp', H28, P28);

results.T28= T28;

h36= NFP('pH2', 'h_pt', P36, T36);

h28= NFP('pH2', 'h_pt', P28, T28);

m37= m36+m28;

h37= ((m36*h36)+(m28*h28))/m37;

P37= P36;

results.P37= P37;

T37computed= NFP('pH2', 't_hp', h37, P37);

PS63= data.PS63;

[~, nS63, TS63, vS63, MS63, AS63, ~, ~] = HGSnozzle(species,nS62,TS62,PS62, PS63, Pa, 'Shifting');

results.PS63= PS63;

results.TS63= TS63;

results.vS63= vS63;

results.MS63= MS63;

results.AS63= AS63;

M51=1;

[T51,~,n51,P51,~] = HGSisentropic(species, nS62, TS62, PS62, 'Shifting','M',M51);

[Rg51, a51]= HGSprop(species,n51,T51, P51,'Rg', 'a');

v51 = M51*a51; 

rho51 = (P51*1e5)/(Rg51*1000*T51); 

A51 = m50/(v51*rho51); 

D51= sqrt(A51*4/pi);

D51= D51*1000;

results.P51= P51;

results.T51= T51;

results.v51= v51;

results.M51= M51;

results.A51= A51;

H51= HGSprop(species, n51, T51, P51, 'H');

H52= H51-Q32;

P52= P51;

v52= v51;

[T52, ~, n52, ~] = HGStp(species, n51, 'H', H52, P52);

[Rg52, a52] = HGSprop(species, n52, T52, P52, 'Rg', 'a');

M52= v52/a52;

rho52 = (P52*1e5)/(Rg52*1000*T52);

A52 = m50/(v52*rho52);

results.P52= P52;

results.T52= T52;

results.v52= v52;

results.M52= M52;

results.A52= A52;

H53= H52-Q28;

P53= P52;

v53= v52;

[T53, ~, n53, ~] = HGStp(species, n52, 'H', H53, P53);

[Rg53, a53] = HGSprop(species, n53, T53, P53, 'Rg', 'a');

M53= v53/a53;

rho53 = (P53*1e5)/(Rg53*1000*T53);

A53 = m50/(v53*rho53);

results.P53= P53;

results.T53= T53;

results.v53= v53;

results.M53= M53;

results.A53= A53;

P54= data.P54;

[T54, v54, M54, A54, ~, ~, ~]=NozzleData(species, n53, v53, T53, P53, P54, Pa, m50, 1, 'Shifting');

results.P54= P54;

results.T54= T54;

results.v54= v54;

results.M54= M54;

results.A54= A54;

results.P34= data.P34;

results.T34= data.T34;

results.P13= data.P13;

results.T13= data.T13;

results.P37= data.P37;

results.T37= data.T37;

results.P25= data.P25;

results.P10= data.P10;

end