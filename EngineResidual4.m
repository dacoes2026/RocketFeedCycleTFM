function error= EngineResidual4(x, data)

P12= x(1)/10;
T12= x(2)/10;
P26= x(3);
P13= x(4);
P25= x(5)/10;
T34= x(6);

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
D51= data.D51;
P54= data.P54;
deltaPS62= data.deltaPS62;

eta95= data.eta95;
eta90= data.eta90;
eta92= data.eta92;

Pa= data.Pa;
OF= data.OF;

tau18= data.tau18;
tau19= data.tau19;
tau23= data.tau23;

deltaP26= data.deltaP26;

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

[T26,W26]= compressor(P25, T25, P26, eta26, 'pH2', mH2);

[P20, T20]= valve(P26, T26, deltaP20, 'pH2');

P40= P20;

P38= P20;

P19= P38*deltaP38;

P18= P19*deltaP19;

[T18,W18]= compressor(P12, T12, P18, eta18, 'O2', m18);

[~, T19]= valve(P18, T18, deltaP19, 'O2');

[~, T38]= valve(P19, T19, deltaP38, 'O2');

MWH2 = NFP('pH2', 'MM'); 
MWO2 = NFP('O2', 'MM');

n20 = m20/MWH2;
n38 = m19/MWO2; 

[T40, n40]= combustionchamber(species, 'pH2', 'O2', n20, n38, P20, T20, P38, T38, P40, etacstar40);

[T13,W13]= compressor(P12, T12, P13, eta13, 'O2', m13);

[P17, T17]= valve(P13, T13, deltaP17, 'O2');

[P21, T21]= valve(P17, T17, deltaP21, 'O2');

P50= P21;

P35= P21;

P34= P35*deltaP35;

[~, T35]= valve(P34, T34, deltaP35, 'H2');

P42= P21;

P41= P42*deltaP42;

[T41, W41, n41] = turbine_mixture(species, n40, P40, T40, P41, eta41);

[P42, T42, n42] = valve_mixture(species, n41, P41, T41, deltaP42);

n35= [m23/NFP('H2', 'MM'); 0; 0; 0; 0; 0];

n21= [0; m13/NFP('O2', 'MM'); 0; 0; 0; 0];

[T50, n50] = combustionchamber3flows(species, n41, P42, T42, n35, 'H2', P35, T35, n21, 'O2', P21, T21, P50, etacstar50);

H50 = HGSprop(species, n50, T50, P50, 'H');

HS62= H50;

PS62= P50/deltaPS62;

[TS62, ~, nS62, ~] = HGStp(species, n50, 'H', HS62, PS62);

[m50, ~, ~]= Nozzleflow(species, nS62, TS62, PS62, D51); %D51= Dthroat

nS62= nS62*m50/mtotal;

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

[P23, T23]= valve(P26, T26, deltaP23, 'pH2');

H23= NFP('pH2', 'h_pt', P23, T23);

H28= H23+(Q28/(m23));

P28= P23/deltaP28;

T28= NFP('pH2', 't_hp', H28, P28);

H28= NFP('H2', 'h_pt', P28, T28);

H29= H28+(Q29/(m23));

P29= P28/deltaP29;

T29= NFP('H2', 't_hp', H29, P29);

[T34computed,W34]= turbine(P29, T29, P34, eta34, 'H2', m23);

P10= P12;

[T10,W10]= compressor(PO2, TO2, P10, eta10, 'O2', mO2);

P15= P12;

[T15,W15]= turbine(P18, T18, P15, eta15, 'O2', m15);

h10= NFP('O2', 'h_pt', P10, T10);

h15= NFP('O2', 'h_pt', P15, T15);

h12= ((mO2*h10)+(m15*h15))/m12;

P12= P10;

T12computed= NFP('O2', 't_hp', h12, P12);

deltaP26computed= P26/P25;


error(1)= (W25+(eta95*W34))/abs(W25);
error(2)= (W10+(eta90*W15))/abs(W10);
error(3)= ((W26+W13+W18)+(eta92*W41))/abs(W26+W13+W18);
error(4)= (T34computed-T34)/T34;
error(5)= (T12computed-T12)/T12; 
error(6)= (deltaP26computed-deltaP26)/deltaP26;

end