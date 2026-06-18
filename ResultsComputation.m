function results= ResultsComputation(data)


tau23= data.tau23;
tau53L= data.tau53L;
tau16= data.tau16;
T11= data.T11;
P11= data.P11;
T53= data.T53;
P53= data.P53;

Dthroatmain=data.Dthroatmain;

epsilonsec1=data.epsilonsec1;

epsilonsec2= data.epsilonsec2;

OFcc= data.OFcc;

PLOX= data.PLOX; %bar

TLOX= data.TLOX; %K

PLH2= data.PLH2; %bar

TLH2= data.TLH2; %K

Pa= data.Pa; %bar

eta11= data.eta11;

eta10= data.eta10;

eta12= data.eta12;

eta15= data.eta15;

eta16= data.eta16;

eta66= data.eta66;

eta68= data.eta68;

P60= data.P60;

deltaP44= data.deltaP44;

Kinj40= data.Kinj40;
deltaPcc= data.deltaPcc;
betableed= data.betableed;

epsilonmain= data.epsilonmain;

Qcc= data.Qcc;

etamain= data.etamain;

deltaP43= data.deltaP43;

P64= data.P64;

%A. From the input data O2 and H2 flow rates are obtained

%1. Tc is computed with the chamber pressure using HGStp. Liguqi state at
%the inlet is assumed.

%We assume generic mass 50

mcc= 1;

mH2= mcc/(OFcc+1);

mO2= OFcc*mcc/(OFcc+1);

species= {'H2', 'O2', 'H2O', 'H', 'O', 'OH'};

nH2= mH2/NFP('H2', 'MM');

nO2= mO2/NFP('O2','MM');

[T60, n60]= combustionchamber(species, 'H2', 'O2', nH2, nO2, P53, T53, P11, T11, P60, 1);

results.T60= T60;

%2. The properties and gamma are computed

[m60,~,~]= Nozzleflow(species, n60, T60, P60, Dthroatmain);

results.m60= m60;

mLOX = m60 * (OFcc / (1 + OFcc)); %O2 flow rate

results.mLOX= mLOX;

m53= m60-mLOX; %H2 flow rate in main nozzle

results.m53= m53;

%2. From pressure at the outlet of pump 11 and tank pressures and the O2
%flow rate the power needed to move it W11 is found

[~,W11]= compressor(PLOX, TLOX, P11, eta11, 'O2', mLOX);

results.W11= W11;

%C. H2 flow

%1. From the power of the O2 pump W16 is found ignoring mechanical
%efficiency

%W16= W11;

%2. W16 depends on the pressure at the inlet and the outlet and mass flow
%m16. p16out will be considered to be known, othrwise it cannot be solved.
%First though, m16 must be found with the following expressions:


%mLH2= m23+m40
%m23= m33+m53L
%m53= m53L+m40
%Thus: mLH2= (m33+m53L)+m40
%mLH2= (m33+(m53-m40)+m40
%mLH2= m33+m53
%Then, m33= (1-tau53L)*m23 & m23=tau23*mLH2
%Thus mLH2= (1-tau53L)*tau23*mLH2+m53
%Meaning : mLH2= m53/(1- (1-tau53L)*tau23)

mLH2= m53/(1-(1-tau53L)*tau23);

m23= tau23*mLH2;

m40= mLH2-m23;

m32= (mLH2-m53);

m33= m32*(1-betableed);

m43= m32*betableed;

m16= tau16*m33;

m15= m33-m16;

m53L= tau53L*m23;

results.mLH2= mLH2;

results.m33= m33;

results.m16= m16;

results.m23= m23;

results.m40= m40;

results.m15= m15;

results.m53L= m53L;


%Now that all the mass flows have been computed, let us continue

P40= P53+Kinj40*m40^2;

P53L= P40;

P10= P40;

results.P10= P10;

[T10,W10]= compressor(PLH2, TLH2, P10, eta10, 'pH2', mLH2);

results.T10= T10;

results.W10= W10;

results.mLH2

P23= P53L;

results.P23= P23;

P22= P23*deltaPcc;

results.P22= P22;

P12= P22;

results.P12= P12;

[T22,W12]= compressor(P10, T10, P22, eta12, 'pH2', m23);

T12= T22;

results.T12= T12;

results.W12= W12;

h22 = NFP('H2', 'h_pt', P22, T22);

h23 = h22+(Qcc/ m23);

T23 = NFP('H2', 't_hp', h23, P23);

results.T23= T23;

[P44, T44]= valve(P23, T23, deltaP44, 'H2');

results.P44= P44;

results.T44= T44;

P45= P44;

T45= T44;

[P43, T43]= valve(P23, T23, deltaP43, 'H2');

P16= P43;

[T16, W16]= turbine(P45, T45, P16, eta16, 'H2', m16);

results.P16= P16;

results.T16= T16;

P15= P16;

[T15, W15]= turbine(P44, T44, P15, eta15, 'H2', m15);

results.P15= P15;

results.T15= T15;

results.W15= W15;

results.W16= W16;

m66= m43+m16;

h43= NFP('H2', 'h_pt', P43, T43);

h16= NFP('H2', 'h_pt', P16, T16);

h54= ((m43*h43)+(m16*h16))/m66;

P54= P16;

T54= NFP('H2', 't_hp', h54, P54);

[T66, P66, v66, M66, F66, Isp66, D66]= SecondaryNozzle(P54, T54, epsilonsec1, 'pH2', Pa, m66, eta66);

results.T66= T66;

results.P66= P66;

results.v66= v66;

results.M66= M66;

results.F66= F66;

results.Isp66= Isp66;

results.D66= D66;

[T68, P68, v68, M68, F68, Isp68, D68]= SecondaryNozzle(P15, T15, epsilonsec2, 'pH2', Pa, m15, eta68);

results.T68= T68;

results.P68= P68;

results.v68= v68;

results.M68= M68;

results.F68= F68;

results.Isp68= Isp68;

results.D68= D68;

n60= n60.*m60;

H60 = HGSprop(species, n60, T60, P60, 'H');

H60cooled = H60 -Qcc;

[T60cooled,~,n60cooled,~]= HGStp(species,n60,'H',H60cooled,P60);

M63=1;

[T63,~,n63,P63,~] = HGSisentropic(species,n60cooled,T60cooled,P60,'Shifting','M',M63);

[Rg63, a63]= HGSprop(species,n63,T63, P63,'Rg', 'a');

v63 = M63*a63; 

rho63 = (P63*1e5)/(Rg63*1000*T63); 

A63 = m60/(v63*rho63); 

D63= sqrt(A63*4/pi);

D63= D63*1000;

results.P63= P63;

results.T63= T63;

results.v63= v63;

results.M63= M63;

results.A63= A63;

results.D63= D63;

[T64, v64, M64, ~, D64, F64, Isp64]=NozzleData(species, n63, v63, T63, P63, P64, Pa, m60, etamain, 'Frozen');

results.P64= P64;

results.T64= T64;

results.v64= v64;

results.M64= M64;

results.D64= D64;

results.Isp64= Isp64;

results.v64= v64;

results.F64= F64;


end