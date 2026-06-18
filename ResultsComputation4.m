function results= ResultsComputation4(data)

P12= data.P12;
T12= data.T12;
P26= data.P26;
P13= data.P13;
P25= data.P25;
T34= data.T34;

PH2= data.PH2;
TH2= data.TH2;
PO2= data.PO2;
TO2= data.TO2;

eta25= data.eta25;
eta10= data.eta10;
eta26= data.eta26;
deltaP20= data.deltaP20;
deltaP23= data.deltaP23;
Q28= data.Q28;
deltaP28= data.deltaP28;
Q29= data.Q29;
deltaP29= data.deltaP29;
eta34= data.eta34;
eta18= data.eta18;
eta15= data.eta15;
deltaP19= data.deltaP19;
deltaP38= data.deltaP38;
etacstar40= data.etacstar40;
etacstar50= data.etacstar50;
eta41= data.eta41;
deltaP42= data.deltaP42;
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
OF= data.OF;

tau18= data.tau18;
tau19= data.tau19;
tau23= data.tau23;

mtotal=1000;

mH2= mtotal/(OF+1);

mO2= OF*mtotal/(OF+1);

%m12= mO2+m15;
%m18= tau18*m12;
%m15= (1-tau19)*m18;
%System of equations, when solved the following expressions are found:

m12= mO2/(1-(tau18*(1-tau19)));

m18= tau18*m12;

m15= (1-tau19)*m18;

%We continue with the rest of masses

m23= tau23*mH2;

m20= (1-tau23)*mH2;

m13= (1-tau18)*m12;

m19= tau19*m18;

m40= m19+m20;

m50= m23+m13+m40;

species = {'H2', 'O2', 'H2O', 'H', 'O', 'OH'};

[T25,W25]= compressor(PH2, TH2, P25, eta25, 'pH2', mH2);

results.T25= T25;

[T26,W26]= compressor(P25, T25, P26, eta26, 'pH2', mH2);

results.T26= T26;

[P20, T20]= valve(P26, T26, deltaP20, 'pH2');

results.P20= P20;

results.T20= T20;

P40= P20;

P38= P20;

P19= P38*deltaP38;

P18= P19*deltaP19;

[T18,W18]= compressor(P12, T12, P18, eta18, 'O2', m18);

results.T18= T18;

[~, T19]= valve(P18, T18, deltaP19, 'O2');

results.P19= P19;

results.T19= T19;

[~, T38]= valve(P19, T19, deltaP38, 'O2');

results.P38= P38;

results.T38= T38;

MWH2 = NFP('pH2', 'MM'); 
MWO2 = NFP('O2', 'MM');

n20 = m20/MWH2;
n38 = m19/MWO2; 

[T40, n40]= combustionchamber(species, 'pH2', 'O2', n20, n38, P20, T20, P38, T38, P40, etacstar40);

results.T40= T40;

[T13,W13]= compressor(P12, T12, P13, eta13, 'O2', m13);

results.T13= T13;

[P17, T17]= valve(P13, T13, deltaP17, 'O2');

results.P17= P17;

results.T17= T17;

[P21, T21]= valve(P17, T17, deltaP21, 'O2');

results.P21= P21;

results.T21= T21;

P50= P21;

P35= P21;

P34= P35*deltaP35;

[~, T35]= valve(P34, T34, deltaP35, 'H2');

results.P35= P35;

results.T35= T35;

P42= P21;

P41= P42*deltaP42;

[T41, W41, n41] = turbine_mixture(species, n40, P40, T40, P41, eta41);

results.T41= T41;

[P42, T42, n42] = valve_mixture(species, n41, P41, T41, deltaP42);

results.P42= P42;

results.T42= T42;

n35= [m23/NFP('H2', 'MM'); 0; 0; 0; 0; 0];

n21= [0; m13/NFP('O2', 'MM'); 0; 0; 0; 0];

[T50, n50] = combustionchamber3flows(species, n41, P42, T42, n35, 'H2', P35, T35, n21, 'O2', P21, T21, P50, etacstar50);

results.T50= T50;

H50 = HGSprop(species, n50, T50, P50, 'H');

HS62= H50;

PS62= P50/deltaPS62;

[TS62, ~, nS62, ~] = HGStp(species, n50, 'H', HS62, PS62);

results.PS62= PS62;

results.TS62= TS62;

[m50, ~, ~]= Nozzleflow(species, nS62, TS62, PS62, D51); %D51= Dthroat

nS62= nS62*m50/mtotal;

results.m50= m50;

mH2old= mH2;

m13old= m13;

m18old= m18;

m40old= m40;

mtotal=m50;

mH2= mtotal/(OF+1);

mO2= OF*mtotal/(OF+1);

m12= mO2/(1-(tau18*(1-tau19)));

m18= tau18*m12;

m15= (1-tau19)*m18;

m23= tau23*mH2;

m20= (1-tau23)*mH2;

m13= (1-tau18)*m12;

m19= tau19*m18;

m40= m19+m20;

m50= m23+m13+m40;

W25= W25*mH2/mH2old;

W26= W26*mH2/mH2old;

W13= W13*m13/m13old;

W18= W18*m18/m18old;

W41= W41*m40/m40old;

results.W25= W25;

results.W26= W26;

results.W13= W13;

results.W18= W18;

results.W41= W41;

[P23, T23]= valve(P26, T26, deltaP23, 'pH2');

results.P23= P23;

results.T23= T23;

H23= NFP('pH2', 'h_pt', P23, T23);

H28= H23+(Q28/(m23));

P28= P23/deltaP28;

T28= NFP('pH2', 't_hp', H28, P28);

results.P28= P28;

results.T28= T28;

H28= NFP('H2', 'h_pt', P28, T28);

H29= H28+(Q29/(m23));

P29= P28/deltaP29;

T29= NFP('H2', 't_hp', H29, P29);

results.P29= P29;

results.T29= T29;

[T34computed,W34]= turbine(P29, T29, P34, eta34, 'H2', m23);

results.T34= T34;

results.W34= W34;

P10= P12;

[T10,W10]= compressor(PO2, TO2, P10, eta10, 'O2', mO2);

results.T10= T10;

results.W10= W10;

P15= P12;

[T15,W15]= turbine(P18, T18, P15, eta15, 'O2', m15);

results.T15= T15;

results.W15= W15;

h10= NFP('O2', 'h_pt', P10, T10);

h15= NFP('O2', 'h_pt', P15, T15);

h12= ((mO2*h10)+(m15*h15))/m12;

P12= P10;

T12computed= NFP('O2', 't_hp', h12, P12);

results.T12= T12;

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

results.P51= P51;

results.T51= T51;

results.v51= v51;

results.M51= M51;

results.A51= A51;

H51= HGSprop(species, n51, T51, P51, 'H');

H52= H51-Q28;

P52= P51;

v52=v51;

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

H53= H52-Q29;

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

[T54, v54, M54, A54, ~, ~, ~]=NozzleData(species, n53, v53, T53, P53, P54, Pa, m50, 1, 'Shifting');

results.P54= P54;

results.T54= T54;

results.v54= v54;

results.M54= M54;

results.A54= A54;

results.P12= P12;

results.P26= P26;

results.P13= P13;

results.P25= P25;

end